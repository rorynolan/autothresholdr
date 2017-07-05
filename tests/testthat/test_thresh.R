library(magrittr)

test_that("auto_thresh works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
  package = "autothresholdr"), as.is = TRUE)
  expect_equal(auto_thresh(img, "IJD"), auto_thresh(img, "default"))
  expect_equal(auto_thresh(img, "H"), 5)
  expect_equal(auto_thresh(img, "huang", ignore_white = TRUE), 5)
  expect_equal(auto_thresh(img, "huang", ignore_white = 255), 5)
  expect_error(auto_thresh(img, "huang", ignore_white = "rory"))
  expect_error(auto_thresh(img, "huang", ignore_white = "rory"))
  expect_equal(auto_thresh(img, "tri"), 3)
  expect_equal(auto_thresh(img, "Otsu"), 13)
  expect_equal(auto_thresh(img, 99), 99)
  mask <- auto_thresh_mask(img, "huang")
  expect_equal(EBImage::imageData(mask), EBImage::imageData(img > 5))
  masked <- EBImage::imageData(auto_thresh_apply_mask(img, "huang"))
  masked5 <- img %T>% {.[. <= 5] <- NA} %>% EBImage::imageData()
  expect_equal(masked, masked5)
  img_neg <- img %T>% {.[1] <- -1}
  expect_error(auto_thresh(img_neg, "huang"))
  expect_error(auto_thresh(matrix(1, nrow = 2, ncol = 2), "huang"))
})

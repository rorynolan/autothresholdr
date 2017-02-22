library(magrittr)

test_that("auto_thresh works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
  package = "autothresholdr"), as.is = TRUE)
  expect_equal(auto_thresh(img, "h"), 5)
  expect_equal(auto_thresh(img, "h", ignore.white = TRUE), 5)
  expect_equal(auto_thresh(img, "h", ignore.white = 255), 5)
  expect_error(auto_thresh(img, "h", ignore.white = "rory"))
  expect_error(auto_thresh(img, "h", ignore.white = "rory"))
  expect_equal(auto_thresh(img, "tri"), 3)
  expect_equal(auto_thresh(img, "Otsu"), 13)
  mask <- auto_thresh_mask(img, "h")
  expect_equal(EBImage::imageData(mask), EBImage::imageData(img > 5))
  masked <- EBImage::imageData(auto_thresh_apply_mask(img, "h"))
  masked5 <- img %T>% {.[. <= 5] <- NA} %>% EBImage::imageData()
  expect_equal(masked, masked5)
  img_neg <- img %T>% {.[1] <- -1}
  expect_error(auto_thresh(img_neg, "h"))
  expect_error(auto_thresh(matrix(1, nrow = 2, ncol = 2), "h"))

})

test_that("IJDefault works", {
  expect_equal(autothresholdr:::IJDefault(c(0, 2, 0)), 1,
               check.attributes = FALSE)
})

test_that("Huang2 works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "Huang"), auto_thresh(img, "Huang2"),
               check.attributes = FALSE)
  expect_equal(autothresholdr:::Huang2(3), 0, check.attributes = FALSE)
})

test_that("Intermodes works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "inter"), 12, check.attributes = FALSE)
})

test_that("IsoData works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "iso"), 13, check.attributes = FALSE)
})

test_that("Li works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "Li"), 7, check.attributes = FALSE)
})

test_that("Intermodes works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "inter"), 12, check.attributes = FALSE)
})

test_that("MaxEntropy works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_error(auto_thresh(img, "maxe"), "failed to find threshold")
})

test_that("Mean works", {
  expect_equal(autothresholdr:::Mean(rep(9, 7)), 3)
})

test_that("MinErrorI works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "mine"), 21, check.attributes = FALSE)
})

test_that("Intermodes works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "inter"), 12, check.attributes = FALSE)
})

test_that("Minimum works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "mini"), 7, check.attributes = FALSE)
})

test_that("Moments works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "mom"), 19, check.attributes = FALSE)
})

test_that("Percentile works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "perc"), 22, check.attributes = FALSE)
})

test_that("RenyiEntropy works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "ren"), 34, check.attributes = FALSE)
})

test_that("Shanbhag works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_equal(auto_thresh(img, "shan"), 23, check.attributes = FALSE)
})

test_that("Yen works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
           package = "autothresholdr"), as.is = TRUE) %>%
    EBImage::imageData()
  expect_error(auto_thresh(img, "y"), "failed to find threshold")
})

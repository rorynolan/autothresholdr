test_that("MeanStackThresh works", {
  library(EBImage)
  img <- imageData(readImage(system.file("extdata", "50.tif",
    package = "autothresholdr"), as.is = TRUE))
  img_thresh_mask <- MeanStackThresh(img, "Otsu")
  expect_equal(round(mean(img_thresh_mask, na.rm = TRUE), 4), 25.2892)
  img_thresh_mask <- MedStackThresh(img, "Triangle")
  expect_equal(round(mean(img_thresh_mask, na.rm = TRUE), 3), 23.622)
  const.arr <- array(2, dim = rep(2, 3))
  expect_warning(MeanStackThresh(const.arr, "tri", skip.consts = TRUE))
  expect_warning(MedStackThresh(const.arr, "tri", skip.consts = TRUE))
  expect_equal(sum(VarPillars(const.arr)), 0)
})

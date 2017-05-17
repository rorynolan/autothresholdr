test_that("mean_stack_thresh works", {
  library(EBImage)
  img <- imageData(readImage(system.file("extdata", "50.tif",
    package = "autothresholdr"), as.is = TRUE))
  img_thresh_mask <- mean_stack_thresh(img, "Otsu")
  expect_equal(round(mean(img_thresh_mask, na.rm = TRUE), 4), 25.2892)
  img_thresh_mask <- med_stack_thresh(img, "Triangle")
  expect_equal(round(mean(img_thresh_mask, na.rm = TRUE), 3), 23.622)
  const.arr <- array(2, dim = rep(2, 3))
  expect_error(mean_stack_thresh(const.arr, "tri"))
  expect_error(med_stack_thresh(const.arr, "tri"))
  expect_equal(sum(var_pillars(const.arr)), 0)
})

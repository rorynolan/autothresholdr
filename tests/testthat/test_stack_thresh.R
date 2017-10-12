test_that("mean_stack_thresh works", {
  img <- system.file('extdata', '50.tif', package = 'autothresholdr') %>%
    tiff::readTIFF(as.is = TRUE, all = TRUE) %>%
    purrr::reduce(~ abind::abind(.x, .y, along = 3))
  img_thresh_mask <- mean_stack_thresh(img, "Otsu")
  expect_equal(round(mean(img_thresh_mask, na.rm = TRUE), 2), 24.09)
  img_thresh_mask <- mean_stack_thresh(img, 13.2)
  expect_equal(round(mean(img_thresh_mask, na.rm = TRUE), 2), 24.08)
  img_thresh_mask <- med_stack_thresh(img, "Triangle")
  expect_equal(round(mean(img_thresh_mask, na.rm = TRUE), 3), 23.583)
  img_thresh_mask <- med_stack_thresh(img + 2 ^ 32, "Triangle")
  expect_equal(round(mean(img_thresh_mask, na.rm = TRUE), 3), 23.622 + 2 ^ 32)
  img_thresh_mask <- mean_stack_thresh(img + 2 ^ 32, "Otsu")
  expect_equal(round(mean(img_thresh_mask, na.rm = TRUE), 2), 24.09 + 2 ^ 32)
  const.arr <- array(2, dim = rep(2, 3))
  expect_error(mean_stack_thresh(const.arr, "tri"))
  expect_error(med_stack_thresh(const.arr, "tri"))
  expect_equal(sum(var_pillars(const.arr)), 0)
})

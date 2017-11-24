context("Stack thresholding")

test_that("mean_stack_thresh works", {
  img_3d <- system.file('extdata', '50.tif', package = 'autothresholdr') %>%
    ijtiff::read_tif() %>%
    {.[, , 1, ]}
  img_3d_thresh_mask <- mean_stack_thresh(img_3d, "Otsu")
  expect_equal(round(mean(img_3d_thresh_mask, na.rm = TRUE), 2), 24.09)
  img_3d_thresh_mask <- mean_stack_thresh(img_3d, 13.2)
  expect_equal(round(mean(img_3d_thresh_mask, na.rm = TRUE), 2), 24.08)
  img_3d_thresh_mask <- med_stack_thresh(img_3d, "Triangle")
  expect_equal(round(mean(img_3d_thresh_mask, na.rm = TRUE), 3), 23.583)
  expect_error(med_stack_thresh(img_3d + 2 ^ 32, "Triangle"),
               "All elements must be <=")
  img_3d_thresh_mask <- mean_stack_thresh(img_3d + 2 ^ 30, "Otsu")
  expect_equal(round(mean(img_3d_thresh_mask, na.rm = TRUE)), 24 + 2 ^ 30)
  const_arr <- array(2, dim = rep(2, 3))
  expect_error(mean_stack_thresh(const_arr, "tri"))
  expect_error(med_stack_thresh(const_arr, "tri"))
  expect_equal(sum(var_pillars(const_arr)), 0)
})

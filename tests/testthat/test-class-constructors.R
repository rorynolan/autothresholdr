test_that("threshed_arr class construction edge cases work", {
  x <- matrix(1:4, nrow = 2)
  expect_equal(threshed_arr(x, 0L),
               threshed_arr(structure(x, class = "array"), 0L))
  x <- array(seq_len(2^3), dim = rep(2, 3))
  expect_equal(threshed_arr(x, 0L),
               threshed_arr(structure(x, class = character()), 0L))
})

test_that("threshed_arr class construction edge cases work", {
  x <- matrix(1:4, nrow = 2)
  expect_equal(threshed_arr(x, 0L),
               threshed_arr(structure(x, class = "array"), 0L))
  x <- array(seq_len(2^3), dim = rep(2, 3))
  expect_equal(class(threshed_arr(structure(x, class = "xyz"), 0L)),
               c("threshed_arr", "xyz", "array"))
})

test_that("masked_arr class construction edge cases work", {
  x <- matrix(TRUE, nrow = 2, ncol = 2)
  expect_equal(masked_arr(x, 0L),
               masked_arr(structure(x, class = "array"), 0L))
  x <- array(FALSE, dim = rep(2, 3))
  expect_equal(class(masked_arr(structure(x, class = "xyz"), 0L)),
               c("masked_arr", "xyz", "array"))
})

test_that("masked_arr class construction edge cases work", {
  x <- array(seq_len(2^4), dim = rep(2, 4))
  expect_equal(
    class(
      stack_threshed_img(structure(x, class = "xyz"), 0L, NA_integer_, "Li")
    ),
    c("stack_threshed_img", "xyz", "array")
  )
})

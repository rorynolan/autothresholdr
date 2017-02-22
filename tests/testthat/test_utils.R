test_that("CanBeInteger works", {
  expect_false(CanBeInteger(c(3, 3.5, NA)))
  expect_error(CanBeInteger(rep(NA, 2)))
})

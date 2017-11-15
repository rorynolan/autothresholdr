context("Utils")

test_that("can_be_integer works", {
  expect_false(can_be_integer(c(3, 3.5, NA)))
  expect_error(can_be_integer(rep(NA, 2)))
})

test_that("translate_fail works", {
  expect_equal(translate_fail(3, "s"), 2 ^ 8 - 1)
  expect_equal(translate_fail(2 ^ 8 + 3, "s"), 2 ^ 16 - 1)
  expect_equal(translate_fail(3, "Z"), 0)
  expect_equal(translate_fail(1:10, 77), 77)
})

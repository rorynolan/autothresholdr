test_that("translate_fail works", {
  expect_equal(translate_fail(3, "s"), 2^8 - 1)
  expect_equal(translate_fail(2^8 + 3, "s"), 2^16 - 1)
  expect_equal(translate_fail(2^30 + 3, "s"), 2^32 - 1)
  expect_equal(translate_fail(3, "Z"), 0)
  expect_equal(translate_fail(1:10, 77), 77)
  expect_error(
    translate_fail(1:3, -1),
    paste0(
      "If `fail` is specified as a number, then that number\\s?",
      "must be.+greater than zero.+You have specified `fail =\\s?",
      "-1`."
    )
  )
})

test_that("custom_stop() errors correctly", {
  expect_error(custom_stop("abc", 123),
               "The arguments in ... must all be of character type.",
               fixed = TRUE)
})


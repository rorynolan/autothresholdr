test_that("auto_thresh works", {
  img <- ijtiff::read_tif(
    system.file("extdata", "eg.tif", package = "autothresholdr"),
    msg = FALSE
  )
  expect_equal(auto_thresh(img, "IJD"), auto_thresh(img, "default"))
  x <- th(5L, FALSE, FALSE, FALSE, "Huang")
  expect_equal(auto_thresh(img, "H"), x)
  img_value_count <- magrittr::set_names(as.data.frame(table(img)),
                                         c("value", "n"))
  expect_equal(
    auto_thresh(img_value_count, "tri"),
    auto_thresh(rbind(img_value_count, data.frame(value = "999", n = 0)), "tri")
  )
  expect_equal(
    auto_thresh(img, "tri", ignore_white = TRUE),
    auto_thresh(c(as.vector(img), 2^16 - 1), "tri", ignore_white = TRUE)
  )
  expect_equal(auto_thresh(img_value_count, "H"), auto_thresh(img, "H"))
  expect_equal(
    auto_thresh(img, "huang", ignore_white = TRUE),
    x %T>% {
      attr(., "ignore_white") <- TRUE
    }
  )
  expect_equal(
    auto_thresh(img, "huang", ignore_white = 255),
    x %T>% {
      attr(., "ignore_white") <- 255
    }
  )
  expect_equal(auto_thresh(img, "otsu")[[1]], 13)
  expect_equal(auto_thresh(img, "otsu", ignore_black = TRUE)[[1]], 22)
  x <- th(3L, FALSE, FALSE, FALSE, "Triangle")
  expect_equal(auto_thresh(img, "tri"), x)
  x <- th(13L, FALSE, FALSE, FALSE, "Otsu")
  expect_equal(auto_thresh(img, "Otsu"), x)
  x <- th(99, NA, NA, NA, NA)
  expect_equal(auto_thresh(img, 99), x)
  mask <- auto_thresh_mask(img, "huang")
  expect_equal(mask, masked_arr(img >= 5, auto_thresh(img, "h")))
  masked <- auto_thresh_apply_mask(img, "huang")
  thresh <- auto_thresh(img, "huang")
  expect_equal(masked, threshed_arr(img %T>% {
    .[. < thresh] <- NA
  }, thresh))
  img_neg <- img %T>% {
    .[1] <- -1
  }
  expect_error(auto_thresh(img_neg, "huang"))
  expect_error(
    auto_thresh(matrix(1, nrow = 2, ncol = 2), "huang"),
    paste0(
      "Cannot threshold.+array with only one unique value.+Your\\s?",
      "`int_arr` has only one unique value which is 1."
    )
  )
  expect_error(
    auto_thresh(c(1, NA), method = "tri"),
    paste0(
      "The input `int_arr` has NA values, but you have\\s?",
      "`ignore_na =.+FALSE`, so the function\\s?",
      "`auto_thresh\\(\\)` has errored.+To tell\\s?",
      "`auto_thresh\\(\\)` to ignore `NA` values, set\\s?",
      "the.+argument `ignore_na = TRUE`."
    )
  )
  x <- th(13L, FALSE, FALSE, TRUE, "Otsu")
  expect_equal(auto_thresh(img %T>% {
    .[1] <- NA
  }, "Otsu", ignore_na = TRUE), x)
  expect_error(
    auto_thresh(rep(NA_integer_, 3), "tri"),
    paste0(
      "`int_arr` must not be all `NA`s.+Every element of your\\s?",
      "`int_arr` is `NA`."
    )
  )
  img[[1]] <- 2^8 - 1
  expect_equal(auto_thresh(img, "otsu", ignore_white = TRUE)[[1]], 13)
})

test_that("auto_thresh works with matrices", {
  img <- ijtiff::read_tif(
      system.file("extdata", "eg.tif", package = "autothresholdr"),
      msg = FALSE
  )[, , 1, 1]
  expect_equal(auto_thresh(img, "IJD"), auto_thresh(img, "default"))
  x <- th(5L, FALSE, FALSE, FALSE, "Huang")
  expect_equal(auto_thresh(img, "H"), x)
  expect_equal(
    auto_thresh(img, "huang", ignore_white = TRUE),
    x %T>% {
      attr(., "ignore_white") <- TRUE
    }
  )
  expect_equal(
    auto_thresh(img, "huang", ignore_white = 255),
    x %T>% {
      attr(., "ignore_white") <- 255
    }
  )
  x <- th(3L, FALSE, FALSE, FALSE, "Triangle")
  expect_equal(auto_thresh(img, "tri"), x)
  x <- th(13L, FALSE, FALSE, FALSE, "Otsu")
  expect_equal(auto_thresh(img, "Otsu"), x)
  x <- th(99, NA, NA, NA, NA)
  expect_equal(auto_thresh(img, 99), x)
  mask <- auto_thresh_mask(img, "huang")
  expect_equal(mask, masked_arr(img >= 5, auto_thresh(img, "h")))
  masked <- auto_thresh_apply_mask(img, "huang")
  thresh <- auto_thresh(img, "huang")
  expect_equal(masked, threshed_arr(img %T>% {
    .[. < thresh] <- NA
  }, thresh))
  img_neg <- img %T>% {
    .[1] <- -1
  }
  expect_error(auto_thresh(img_neg, "huang"))
  expect_error(
    auto_thresh(matrix(1, nrow = 2, ncol = 2), "huang"),
    paste0(
      "Cannot threshold an array with only one unique\\s?",
      "value.+Your `int_arr` has only one unique value which\\s?",
      "is 1."
    )
  )
  expect_error(
    auto_thresh(c(1, NA), method = "tri"),
    paste0(
      "The input `int_arr` has NA values, but you have\\s?",
      "`ignore_na =.+FALSE`, so the function\\s?",
      "`auto_thresh\\(\\)` has errored.+To tell\\s?",
      "`auto_thresh\\(\\)` to ignore `NA` values, set\\s?",
      "the.+argument `ignore_na = TRUE`."
    )
  )
  x <- th(13L, FALSE, FALSE, TRUE, "Otsu")
  expect_equal(auto_thresh(img %T>% {
    .[1] <- NA
  }, "Otsu", ignore_na = TRUE), x)
})

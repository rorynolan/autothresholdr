suppressPackageStartupMessages(library(magrittr, quietly = TRUE))

test_that("auto_thresh works", {
  img <- EBImage::readImage(system.file("extdata", "eg.tif",
  package = "autothresholdr"), as.is = TRUE)
  expect_equal(auto_thresh(img, "IJD"), auto_thresh(img, "default"))
  x <- 5
  desirable_thresh_atts <- c("autothresh_method",
                             "ignore_black", "ignore_white")
  attributes(x)[desirable_thresh_atts] <- list("Huang", FALSE, FALSE)
  expect_equal(auto_thresh(img, "H"), x)
  expect_equal(auto_thresh(img, "huang", ignore_white = TRUE),
               x %T>% {attr(., "ignore_white") <- TRUE})
  expect_equal(auto_thresh(img, "huang", ignore_white = 255),
               x %T>% {attr(., "ignore_white") <- 255})
  expect_error(auto_thresh(img, "huang", ignore_white = "rory"))
  expect_error(auto_thresh(img, "huang", ignore_white = "rory"))
  x <- 3
  attributes(x)[desirable_thresh_atts] <- list("Triangle", FALSE, FALSE)
  expect_equal(auto_thresh(img, "tri"), x)
  x <- 13
  attributes(x)[desirable_thresh_atts] <- list("Otsu", FALSE, FALSE)
  expect_equal(auto_thresh(img, "Otsu"), x)
  x <- 99
  attributes(x)[desirable_thresh_atts] <- list(NA, FALSE, FALSE)
  expect_equal(auto_thresh(img, 99), x)
  img <- EBImage::imageData(img)
  mask <- auto_thresh_mask(img, "huang")
  x <- img >= 5
  desirable_thresh_atts <- c("autothresh_method",
                             "ignore_black", "ignore_white")
  attributes(x)[c(desirable_thresh_atts, "threshold")] <-
    list("Huang", FALSE, FALSE, 5)
  expect_equal(mask, x)
  masked <- auto_thresh_apply_mask(img, "huang")
  x <- img %T>% {.[. < 5] <- NA}
  attributes(x)[c(desirable_thresh_atts, "threshold")] <-
    list("Huang", FALSE, FALSE, 5)
  expect_equal(masked, x)
  img_neg <- img %T>% {.[1] <- -1}
  expect_error(auto_thresh(img_neg, "huang"))
  expect_error(auto_thresh(matrix(1, nrow = 2, ncol = 2), "huang"))
  expect_error(auto_thresh(c(1, NA), method = "tri"), "input int_arr has NA ")
  x <- 13
  attributes(x)[desirable_thresh_atts] <- list("Otsu", FALSE, FALSE)
  expect_equal(auto_thresh(img %T>% {.[1] <- NA}, "Otsu", ignore_na = TRUE), x)
})

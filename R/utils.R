## Translate the fail argument from what the user selects to what failed pixels
## should be set to.
translate_fail <- function(arr, fail) {
  stopifnot(length(fail) == 1)
  if (is.na(fail)) return(NA)
  if (is.numeric(fail)) {
    stopifnot(fail >= 0)
  } else if (is.character(fail)) {
    fail <- RSAGA::match.arg.ext(fail, c("saturate", "zero"),
                                 ignore.case = TRUE)
  }
  if (fail == "zero") {
    fail <- 0
  } else if (fail == "saturate") {
    mx <- max(arr, na.rm = TRUE)
    bits_per_sample <- 8
    if (mx > 2 ^ 16 - 1) {
      bits_per_sample <- 32
    } else if (mx > 2 ^ 8 - 1) {
      bits_per_sample <- 16
    }
    fail <- 2 ^ bits_per_sample - 1
  }
  fail
}

eval_text <- function(string) {
  checkmate::assert_scalar(string)
  checkmate::assert_character(string)
  eval(parse(text = string))
}

#' Pillar statistics.
#'
#' Get the sums/means/medians/variances of pillars of a 3d array.
#'
#' For a 3-dimensional array \code{arr3d}, pillar \code{ij} is defined as
#' \code{arr3d[i, j, ]}. These functions compute the mean, median and variance
#' of each pillar.
#'
#' @param arr3d A 3-dimensional array.
#'
#' @return A matrix where element \code{i,j} is equal to
#' \code{sum(arr3d[i, j, ])}, \code{mean(arr3d[i, j, ])},
#' \code{median(arr3d[i, j, ])}, or \code{var(arr3d[i, j, ])}.
#'
#' @examples
#' m3 <- array(1:16, dim = c(2, 2, 4))
#' mean_pillars(m3)
#' median_pillars(m3)
#' var_pillars(m3)
#'
#' @name pillar-stats
NULL

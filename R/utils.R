#' Check if a number could be considered to be an integer.
#'
#' Could the input numeric vector be considered to be an integer vector, i.e. is
#' it equal to its floor?
#' @param x A numeric vector.
#' @param na_rm Should NAs be removed?
#' @return A boolean. `TRUE` if the argument can be considered to be integer or
#'   `FALSE` otherwise.
#' @examples
#' can_be_integer(c(3.0, 6))
#' can_be_integer(c(3.0, 6, NA))
#' can_be_integer(c(3, 3.5, NA))
#' @export
can_be_integer <- function(x, na_rm = TRUE) {
  if (na_rm) {
    na_poss <- is.na(x)
    if (sum(na_poss) == length(x)) stop ("x is all NAs")
    x <- x[!na_poss]
  }
  isTRUE(all.equal(x, floor(x)))
}

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
    fail = 0
  } else if (fail == "saturate") {
    mx <- max(arr, na.rm = TRUE)
    if (mx >= 2 ^ 8) {
      bits.per.sample <- 16
    } else {
      bits.per.sample <- 8
    }
    fail <- 2 ^ bits.per.sample - 1
  }
  fail
}

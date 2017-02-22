#' Check if a number could be considered to be an integer.
#'
#' After padding is removed, could the input numeric vector be considered to be
#' an integer vector, i.e. is it equal to its floor?
#' @param x A numeric vector.
#' @param na_rm Should NAs be removed?
#' @return A boolean. `TRUE` if the argument can be considered to be integer or
#'   `FALSE` otherwise.
#' @examples
#' CanBeInteger(c(3, 3.5, NA))
#' @export
CanBeInteger <- function(x, na_rm = TRUE) {
  if (na_rm) {
    na_poss <- is.na(x)
    if (sum(na_poss) == length(x)) stop ("x is all NAs")
    x <- x[!na_poss]
  }
  isTRUE(all.equal(x, floor(x)))
}

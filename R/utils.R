AllEqual <- function(a, b = NA, allow = TRUE, cn = FALSE) {
  if (is.na(b[1])) {
    return(length(unique(a)) == 1)
  } else {
    if (allow) {
      if (length(a) == 1) {
        a <- rep(a, length(b))
        if (is.array(b)) b <- as.vector(b)
      }
      if (length(b) == 1) {
        b <- rep(b, length(a))
        if (is.array(a)) a <- as.vector(a)
      }
    }
    return(isTRUE(all.equal(a, b, check.names = cn)))
  }
}

CanBeInteger <- function(x, na_rm = TRUE) {
  if (na_rm) {
    na_poss <- is.na(x)
    if (sum(na_poss) == length(x)) stop ("x is all NAs")
    x <- x[!na_poss]
  }
  AllEqual(x, floor(x))
}

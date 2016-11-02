AllEqual <- function(a, b = NA, allow = T, cn = F) {
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

CanBeInteger <- function(x) {
  AllEqual(x, floor(x))
}

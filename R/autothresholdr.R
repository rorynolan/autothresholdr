#' @useDynLib autothresholdr
#' @importFrom Rcpp sourceCpp
#' @importFrom magrittr '%>%' '%T>%'
#' @importFrom EBImage readImage
NULL
## quiets concerns of R CMD check re: the .'s that appear in pipelines
if (getRversion() >= "2.15.1")  utils::globalVariables(".")

# This is needed to make the package work,
#   having the required java classes contained in the jar file in inst/java.
.onLoad <- function(libname, pkgname) {
  rJava::.jpackage(pkgname, lib.loc = libname)
}

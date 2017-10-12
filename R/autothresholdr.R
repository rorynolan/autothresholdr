#' @useDynLib autothresholdr, .registration = TRUE
#' @importFrom Rcpp sourceCpp
#' @importFrom magrittr '%>%' '%T>%' '%<>%'
#' @importFrom tiff readTIFF
#' @importFrom abind abind
#' @importFrom purrr as_vector
#' @importFrom graphics image
NULL
## quiets concerns of R CMD check re: the .'s that appear in pipelines
if (getRversion() >= "2.15.1")  utils::globalVariables(".")

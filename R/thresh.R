#' Automatically threshold an image.
#'
#' These functions apply the ImageJ "Auto Threshold" plugin's image thresholding
#' methods. The available methods are "Default", "Huang", "Intermodes",
#' "IsoData", "Li", "MaxEntropy", "Mean", "MinError", "Minimum", "Moments",
#' "Otsu", "Percentile", "RenyiEntropy", "Shanbhag", "Triangle", "Yen". Read
#' about them at \url{http://imagej.net/Auto_Threshold}.
#'
#' \code{NA} values are automatically ignored.
#'
#' @param int_arr An array (or vector) of \emph{integers}.
#' @param method The name of the method you wish to use (e.g. "Huang"). Partial
#'   matching is performed i.e. \code{method = "h"} is enough to get you "Huang"
#'   and \code{method = "in"} is enough to get you "Intermodes".
#' @param fail When using \code{auto_thresh_apply_mask}, to what value do you
#'   wish to set the pixels which fail to exceed the threshold.
#'
#' @return \code{auto_thresh} returns an integer, the image threshold value.
#'   Pixels exceeding this threshold are passed, but pixels at or below this
#'   level are failed.
#'
#'   \code{auto_thresh_mask} returns a binarized version of the input, with a
#'   value of \code{TRUE} at points which exceed the threshold and \code{FALSE}
#'   at those which do not. This has an attribute "threshold" to tell you what
#'   the threshold value was.
#'
#'   \code{auto_thresh_apply_mask} returns the original input masked by the
#'   threshold, i.e. all points not exceeding the threshold are set to a
#'   user-defined value (default \code{NA}). This has an attribute "threshold"
#'   to tell you what the threshold value was.
#'
#' @export
auto_thresh <- function(int_arr, method) {
  available_methods <- c("Default", "Huang", "Intermodes", "IsoData", "Li",
                         "MaxEntropy", "Mean", "MinError", "Minimum",
                         "Moments", "Otsu", "Percentile", "RenyiEntropy",
                         "Shanbhag", "Triangle", "Yen")
  method <- RSAGA::match.arg.ext(method, available_methods,
                                 ignore.case = TRUE, numeric = TRUE) %>%
                                 {available_methods[.]}
  if ((!CanBeInteger(int_arr)) || any(int_arr < 0, na.rm = TRUE)) {
    stop("int_arr must be a matrix of non-negative integers.")
  }
  rim <- range(int_arr, na.rm = TRUE)
  im_hist <- factor(int_arr, levels = rim[1]:rim[2]) %>%
    table %>% as.vector
  if (length(im_hist) < 2) {
    stop("The image you're trying to threshold has only one unique value, ",
         "to perform thresholding, it needs at least two unique values.")
  }
  autothresh_class <- rJava::.jnew("Auto_Threshold")
  rJava::.jcall(autothresh_class, "I", method, im_hist) + rim[1]
}

#' @rdname auto_thresh
#' @export
auto_thresh_mask <- function(int_arr, method) {
  thresh <- auto_thresh(int_arr, method)
  mask <- int_arr > thresh
  attr(mask, "threshold") <- thresh
  mask
}

#' @rdname auto_thresh
#' @export
auto_thresh_apply_mask <- function(int_arr, method, fail = NA) {
  mask <- auto_thresh_mask(int_arr, method)
  int_arr[!mask] <- fail
  attr(int_arr, "threshold") <- attr(mask, "threshold")
  int_arr
}


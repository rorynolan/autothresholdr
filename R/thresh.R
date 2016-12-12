#' Automatically threshold an image.
#'
#' These functions apply the ImageJ "Auto Threshold" plugin's image thresholding
#' methods. The available methods are "Default", "Huang", "Intermodes",
#' "IsoData", "Li", "MaxEntropy", "Mean", "MinError", "Minimum", "Moments",
#' "Otsu", "Percentile", "RenyiEntropy", "Shanbhag", "Triangle", "Yen". Read
#' about them at \url{http://imagej.net/Auto_Threshold}.
#'
#' @param int_arr An array of \emph{integers}.
#' @param method The name of the method you wish to use (e.g. "Huang"). Partial
#'   matching is performed i.e. \code{method = "h"} is enough to get you "Huang"
#'   and \code{method = "in"} is enough to get you "Intermodes".
#' @param fail When using \code{auto_thresh_apply_mask}, to what value do you
#'   wish to set the pixels which fail to exceed the threshold.
#'
#' @return
#' \code{auto_thresh} returns an integer, the image threshold value.
#'   Pixels exceeding this threshold are passed, but pixels at or below this
#'   level are failed.
#'
#'   \code{auto_thresh_mask} returns a binarized version of the input image,
#'   with a value of \code{TRUE} at pixels which exceed the threshold and
#'   \code{FALSE} at pixels which do not.
#'
#'   \code{auto_thresh_apply_mask} returns the original image masked by the
#'   threshold, i.e. all pixels not exceeding the threshold are set to a
#'   user-defined value (default \code{NA}).
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
  if ((!CanBeInteger(int_arr)) || any(int_arr < 0)) {
    stop("int_arr must be a matrix of non-negative integers.")
  }
  rim <- range(int_arr)
  im_hist <- factor(int_arr, levels = rim[1]:rim[2]) %>%
    table %>% as.vector
  autothresh_class <- rJava::.jnew("Auto_Threshold")
  rJava::.jcall(autothresh_class, "I", method, im_hist) + rim[1]
}

#' @rdname auto_thresh
#' @export
auto_thresh_mask <- function(int_arr, method) {
  int_arr > auto_thresh(int_arr, method)
}

#' @rdname auto_thresh
#' @export
auto_thresh_apply_mask <- function(int_arr, method, fail = NA) {
  int_arr[!auto_thresh_mask(int_arr, method)] <- fail
  int_arr
}


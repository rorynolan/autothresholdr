#' Automatically threshold an image.
#'
#' These functions apply the ImageJ "Auto Threshold" plugin's image thresholding
#' methods. The available methods are "Default", "Huang", "Intermodes",
#' "IsoData", "Li", "MaxEntropy", "Mean", "MinError", "Minimum", "Moments",
#' "Otsu", "Percentile", "RenyiEntropy", "Shanbhag", "Triangle", "Yen". Read
#' about them at \url{http://imagej.net/Auto_Threshold}.
#'
#' @param img_mat An array of \emph{integers}.
#' @param method The full name (with correct case) of the method you wish to use
#'   (e.g. "Huang").
#'
#' @return \code{auto_thresh} returns an integer, the image threshold value.
#'   Pixels exceeding this threshold are passed, but pixels at or below this
#'   level are failed.
#'
#'   \code{mask_auto_thresh} returns a binarized version of the input image, with a
#'   value of \code{TRUE} at pixels which exceed the threshold and \code{FALSE}
#'   at pixels which do not.
#'
#'   \code{use_mask_auto_thresh} returns the original image masked by the
#'   threshold, i.e. all pixels not exceeding the threshold are set to zero.
#'
#' @export
auto_thresh <- function(img_mat, method) {
  available_methods <- c("Default", "Huang", "Intermodes", "IsoData", "Li",
                         "MaxEntropy", "Mean", "MinError", "Minimum",
                         "Moments", "Otsu", "Percentile", "RenyiEntropy",
                         "Shanbhag", "Triangle", "Yen")
  method <- RSAGA::match.arg.ext(method, available_methods,
                                 ignore.case = TRUE, numeric = TRUE) %>%
                                 {available_methods[.]}
  if ((!CanBeInteger(img_mat)) || any(img_mat < 0)) {
    stop("img_mat must be a matrix of non-negative integers.")
  }
  rim <- range(img_mat)
  im_hist <- factor(img_mat, levels = rim[1]:rim[2]) %>%
    table %>% as.vector
  autothresh_class <- rJava::.jnew("Auto_Threshold")
  rJava::.jcall(autothresh_class, "I", method, im_hist) + rim[1]
}

#' @rdname auto_thresh
#' @export
auto_thresh_mask <- function(img_mat, method) {
  img_mat > auto_thresh(img_mat, method)
}

#' @rdname auto_thresh
#' @export
auto_thresh_apply_mask <- function(img_mat, method) {
  img_mat[!auto_thresh_mask(img_mat, method)] <- 0
  img_mat
}


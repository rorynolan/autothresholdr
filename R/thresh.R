#' Automatically threshold an image.
#'
#' These functions apply the ImageJ "Auto Threshold" plugin's image thresholding
#' methods. The available methods are "Default", "Huang", "Intermodes",
#' "IsoData", "Li", "MaxEntropy", "Mean", "MinError", "Minimum", "Moments",
#' "Otsu", "Percentile", "RenyiEntropy", "Shanbhag", "Triangle", "Yen". Read
#' about them at \url{http://imagej.net/Auto_Threshold}.
#'
#' @param img_mat An array of \emph{integers} with a "bits" attribute, where
#'   theis must be 8 or 16. Note that \code{\link[EBImage]{EBImage}}'s
#'   \code{\link[EBImage]{display}} does not read in images as integers, nor
#'   does it give them a "bits" attribute, but the
#'   \code{\link[nandb]{ReadImageData}} function from the nandb package (\url{http://github.com/rorynolan/nandb}) does these things.
#' @param method The full name (with correct case) of the method you wish to use
#'   (e.g. "Huang").
#'
#' @return \code{auto_thresh} returns an integer, the image threshold value.
#'   Pixels exceeding this threshold are passed, but pixels at or below this
#'   level are failed.
#'
#'   \code{i_auto_thresh} returns a binarized version of the input image, with a
#'   value of \code{TRUE} at pixels which exceed the threshold and \code{FALSE}
#'   at pixels which do not.
#'
#'   \code{imask_auto_thresh} returns the original image masked by the
#'   threshold, i.e. all pixels not exceeding the threshold are set to zero.
#'
#' @export
auto_thresh <- function(img_mat, method) {
  if (!CanBeInteger(img_mat)) {
    stop("img_mat must be a mtrix of integers.")
  }
  bits <- attr(img_mat, "bits")
  if (is.null(bits)) {
    stop("img_mat must have a 'bits' attribute.")
  }
  if (! bits %in% c(8, 16)) {
    stop("This function only works on 8- or 16-bit images.")
  }
  im_hist <- sapply(seq_len(2 ^ bits) - 1, function(x) {
    sum(x == img_mat)
  })
  at_class <- rJava::.jnew("Auto_Threshold")
  rJava::.jcall(at_class, "I", method, im_hist)
}

#' @rdname auto_thresh
#' @export
i_auto_thresh <- function(img_mat, method) {
  img_mat > auto_thresh(img_mat, method)
}

#' @rdname auto_thresh
#' @export
imask_auto_thresh <- function(img_mat, method) {
  img_mat[!i_auto_thresh(img_mat, method)] <- 0
  img_mat
}


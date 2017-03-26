#' Threshold every image frame in a stack based on their mean/median.
#'
#' This function finds a threshold based on all of the frames, then takes the
#' mean/median of all the frames in the stack image, uses this to create a mask
#' and then applies this mask to every frame in the stack (so for a given pillar
#' in the image stack, either all the pixels therein are thresholded away, all
#' are untouched).
#'
#' @param arr3d A 3-dimensional array (the image stack) where the \eqn{n}th
#'   slice is the \eqn{n}th image in the time series.
#' @param method The thresholding method to use. See
#'   [autothresholdr::auto_thresh].
#' @param fail To which value should pixels not exceeeding the threshold be set?
#' @param skip.consts An array with only one value (a 'constant array') won't
#'   threshold properly. By default the function would give an error, but by
#'   setting this parameter to `TRUE`, the array would instead be skipped (the
#'   function will return the original array) and give a warning.
#'
#' @return A 3d array, the thresholded stack. Pillars not exceeding the
#'   threshold are set to zero. The attribute 'threshold' gives the value used
#'   for thresholding.
#'
#' @examples
#' library(EBImage)
#' img <- imageData(readImage(system.file('extdata', '50.tif',
#'                                        package = 'autothresholdr'),
#'                            as.is = TRUE))
#' display(normalize(img[, , 1]), method = 'raster')
#' img_thresh_mask <- MeanStackThresh(img, 'Otsu')
#' display(img_thresh_mask[, , 1] > 0, method = 'r')
#' display(normalize(img[, , 1]), method = 'raster')
#' img_thresh_mask <- MedStackThresh(img, 'Triangle')
#' display(img_thresh_mask[, , 1] > 0, method = 'r')
#'
#' @export
MeanStackThresh <- function(arr3d, method, fail = NA, skip.consts = FALSE) {
  stopifnot(length(dim(arr3d)) == 3)
  if (length(unique(as.vector(arr3d))) == 1 && skip.consts) {
    warning("Constant array, skipping thresholding.")
    return(arr3d)
  }
  thresh <- autothresholdr::auto_thresh(arr3d, method)
  med.stack <- MeanPillars(arr3d)
  med.stack.mask <- med.stack > thresh
  set.indices <- rep(!as.vector(med.stack.mask), dim(arr3d)[3])
  arr3d[set.indices] <- fail
  attr(arr3d, "threshold") <- thresh
  arr3d
}

#' @rdname MeanStackThresh
#'
#' @examples
#' img_thresh_mask <- MedStackThresh(img, 'Triangle')
#' display(img_thresh_mask[, , 1] > 0, method = 'r')
#'
#' @export
MedStackThresh <- function(arr3d, method, fail = NA, skip.consts = FALSE) {
  stopifnot(length(dim(arr3d)) == 3)
  if (length(unique(as.vector(arr3d))) == 1 && skip.consts) {
    warning("Constant array, skipping thresholding.")
    return(arr3d)
  }
  thresh <- autothresholdr::auto_thresh(arr3d, method)
  med.stack <- MedianPillars(arr3d)
  med.stack.mask <- med.stack > thresh
  set.indices <- rep(!as.vector(med.stack.mask), dim(arr3d)[3])
  arr3d[set.indices] <- fail
  attr(arr3d, "threshold") <- thresh
  arr3d
}

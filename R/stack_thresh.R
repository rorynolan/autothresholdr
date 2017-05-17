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
#' img_thresh_mask <- mean_stack_thresh(img, 'Otsu')
#' display(img_thresh_mask[, , 1] > 0, method = 'r')
#' display(normalize(img[, , 1]), method = 'raster')
#' img_thresh_mask <- med_stack_thresh(img, 'Triangle')
#' display(img_thresh_mask[, , 1] > 0, method = 'r')
#'
#' @export
mean_stack_thresh <- function(arr3d, method, fail = NA) {
  stopifnot(length(dim(arr3d)) == 3)
  if (length(unique(as.vector(arr3d))) == 1) {
    stop("The array given for thresholding is constant ",
         "(all the values are the same). Aborting.")
  }
  thresh <- auto_thresh(arr3d, method)
  mean.stack <- mean_pillars(arr3d)
  mean.stack.mask <- mean.stack > thresh
  set.indices <- rep(!as.vector(mean.stack.mask), dim(arr3d)[3])
  arr3d[set.indices] <- fail
  attr(arr3d, "threshold") <- thresh
  arr3d
}

#' @rdname mean_stack_thresh
#'
#' @examples
#' img_thresh_mask <- med_stack_thresh(img, 'Triangle')
#' display(img_thresh_mask[, , 1] > 0, method = 'r')
#'
#' @export
med_stack_thresh <- function(arr3d, method, fail = NA) {
  stopifnot(length(dim(arr3d)) == 3)
  if (length(unique(as.vector(arr3d))) == 1) {
    stop("The array given for thresholding is constant ",
         "(all the values are the same). Aborting.")
  }
  thresh <- auto_thresh(arr3d, method)
  med.stack <- median_pillars(arr3d)
  med.stack.mask <- med.stack > thresh
  set.indices <- rep(!as.vector(med.stack.mask), dim(arr3d)[3])
  arr3d[set.indices] <- fail
  attr(arr3d, "threshold") <- thresh
  arr3d
}

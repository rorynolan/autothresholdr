#' Threshold every image frame in a stack based on their mean.
#'
#' This function finds a threshold based on the sum all of the frames, uses this
#' to create a mask and then applies this mask to every frame in the stack (so
#' for a given pillar in the image stack, either all the pixels therein are
#' thresholded away, all are untouched).
#'
#' Values greater than or equal to the found threshold \emph{pass} the
#' thresholding and values less than the threshold \emph{fail} the thresholding.
#'
#' It's called `mean_stack_thresh()` and not `sum_stack_thresh()` because its
#' easier for people to visualise the mean if an image series rather than the
#' sum, but for the sake of this procedure, both are equivalent, except for the
#' fact that the java routine invoked inside this function prefers integers,
#' which we get by using a sum but not by using a mean.
#'
#' \itemize{ \item{`NA` values are automatically ignored.} \item{For
#' `ignore.white = TRUE`, if the maximum value in the array is one of `2^8-1`,
#' `2^12-1`, `2^16-1` or `2^32-1`, then those max values are ignored. That's
#' because they're the white values in 8, 12, 16 and 32-bit images respectively
#' (and these are the common image bit sizes to work with). This guesswork has
#' to be done because `R` does not know how many bits the image was on disk.
#' This guess is very unlikely to be wrong, and if it is, the consequences are
#' negligible anyway. If you're very concerned, then just specify the max value
#' in the `ignore.white` argument.} \item{If you have set `ignore.black = TRUE`
#' and/or `ignore.white = TRUE` but you are still getting error/warning messages
#' telling you to try them, then your chosen method is not working for the given
#' array, so you should try a different method.} }
#'
#' @param arr3d A 3-dimensional array (the image stack) where the \eqn{n}th
#'   slice is the \eqn{n}th image in the time series.
#' @param method The thresholding method to use. See [auto_thresh()].
#' @param ignore_black Ignore black pixels/elements (zeros) when performing the
#'   thresholding?
#' @param ignore_white Ignore white pixels when performing the thresholding? If
#'   set to `TRUE`, the function makes a good guess as to what the white
#'   (saturated) value would be (see "Details"). If this is set to a number, all
#'   pixels with value greater than or equal to that number are ignored.
#' @param fail To what value do you wish to set the pixels which fail to exceed
#'   the threshold. `fail = 'saturate'` sets them to saturated value (see
#'   "Details"). `fail = 'zero'` sets them to zero. You can also specify
#'   directly here a natural number (must be between 0 and 2 ^ 16 - 1) to use in
#'   place of `NA`s.
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
mean_stack_thresh <- function(arr3d, method, fail = NA,
                              ignore_black = FALSE, ignore_white = FALSE) {
  d <- dim(arr3d)
  stopifnot(length(d) == 3, length(method) == 1)
  if (length(unique(as.vector(arr3d))) == 1) {
    stop("The array given for thresholding is constant ",
         "(all the values are the same). Aborting.")
  }
  fail <- translate_fail(arr3d, fail)
  if (is.numeric(method)) {
    thresh <- method
  } else {
    sum_stack <- sum_pillars(arr3d)
    scaling_factor <- 1
    max32int <- 2 ^ 31 - 1
    mx <- max(sum_stack)
    if (mx > max32int) {
      scaling_factor <- max32int / mx
      sum_stack <- round(sum_stack * scaling_factor)
    }
    thresh <- auto_thresh(sum_stack, method, ignore_black = ignore_black,
                          ignore_white = ignore_white) /
      (scaling_factor * d[3])
  }
  mean_stack <- mean_pillars(arr3d)
  mean_stack_mask <- mean_stack >= thresh
  set_indices <- rep(!as.vector(mean_stack_mask), d[3])
  arr3d[set_indices] <- fail
  desirable_thresh_atts <- c("autothresh_method",
                             "ignore_black", "ignore_white")
  attributes(arr3d)[c(desirable_thresh_atts, "threshold")] <-
    c(attributes(thresh)[desirable_thresh_atts], thresh)
  arr3d
}

#' Threshold every image frame in a stack based on their median.
#'
#' This function finds a threshold based on all of the frames, then takes the
#' median of all the frames in the stack image, uses this to create a mask and
#' then applies this mask to every frame in the stack (so for a given pillar in
#' the image stack, either all the pixels therein are thresholded away, all are
#' untouched).
#'
#' Values greater than or equal to the found threshold \emph{pass} the
#' thresholding and values less than the threshold \emph{fail} the thresholding.
#'
#' \itemize{ \item{`NA` values are automatically ignored.} \item{For
#' `ignore.white = TRUE`, if the maximum value in the array is one of `2^8-1`,
#' `2^12-1`, `2^16-1` or `2^32-1`, then those max values are ignored. That's
#' because they're the white values in 8, 12, 16 and 32-bit images respectively
#' (and these are the common image bit sizes to work with). This guesswork has
#' to be done because `R` does not know how many bits the image was on disk.
#' This guess is very unlikely to be wrong, and if it is, the consequences are
#' negligible anyway. If you're very concerned, then just specify the max value
#' in the `ignore.white` argument.} \item{If you have set `ignore.black = TRUE`
#' and/or `ignore.white = TRUE` but you are still getting error/warning messages
#' telling you to try them, then your chosen method is not working for the given
#' array, so you should try a different method.} }
#'
#' @param arr3d A 3-dimensional array (the image stack) where the \eqn{n}th
#'   slice is the \eqn{n}th image in the time series.
#' @param method The thresholding method to use. See
#'   [autothresholdr::auto_thresh].
#' @param fail To which value should pixels failing to meet the threshold be
#'   set?
#' @param ignore_black Ignore black pixels/elements (zeros) when performing the
#'   thresholding?
#' @param ignore_white Ignore white pixels when performing the thresholding? If
#'   set to `TRUE`, the function makes a good guess as to what the white
#'   (saturated) value would be (see "Details"). If this is set to a number, all
#'   pixels with value greater than or equal to that number are ignored.
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
med_stack_thresh <- function(arr3d, method, fail = NA,
                             ignore_black = FALSE, ignore_white = FALSE) {
  stopifnot(length(dim(arr3d)) == 3)
  if (length(unique(as.vector(arr3d))) == 1) {
    stop("The array given for thresholding is constant ",
         "(all the values are the same). Aborting.")
  }
  fail <- translate_fail(arr3d, fail)
  thresh <- auto_thresh(arr3d, method, ignore_black = ignore_black,
                        ignore_white = ignore_white)
  med_stack <- median_pillars(arr3d)
  med_stack_mask <- med_stack >= thresh
  set_indices <- rep(!as.vector(med_stack_mask), dim(arr3d)[3])
  arr3d[set_indices] <- fail
  desirable_thresh_atts <- c("autothresh_method",
                             "ignore_black", "ignore_white")
  attributes(arr3d)[c(desirable_thresh_atts, "threshold")] <-
    c(attributes(thresh)[desirable_thresh_atts], thresh)
  arr3d
}

ithresh <- function(img_mat, method) {
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
  .jcall(at_class, "I", method, im_hist)
}

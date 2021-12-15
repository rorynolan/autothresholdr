argchk_auto_thresh <- function(int_arr, method,
                               ignore_black, ignore_white, ignore_na) {
  if (is.numeric(method)) {
    return(list(int_arr = int_arr, method = method))
  }
  method <- tolower(method)
  if (startsWith("default", method)) method <- "IJDefault"
  if (startsWith("huang", method)) method <- "Huang"
  available_methods <- c(
    "IJDefault", "Huang", "Huang2", "Intermodes",
    "IsoData", "Li", "MaxEntropy", "Mean", "MinErrorI",
    "Minimum", "Moments", "Otsu", "Percentile",
    "RenyiEntropy", "Shanbhag", "Triangle", "Yen"
  )
  method <- strex::match_arg(method, available_methods,
                             ignore_case = TRUE
  )
  checkmate::assert_scalar(method)
  checkmate::assert(
    checkmate::check_number(method),
    checkmate::check_string(method)
  )
  if (is.data.frame(int_arr) &&
      all(c("value", "n") %in% tolower(names(int_arr)))) {
    int_arr = data.frame(
      value = as.integer(
        as.character(int_arr[[match("value", tolower(names(int_arr)))]])
      ),
      n = as.integer(int_arr[[match("n", tolower(names(int_arr)))]])
    )
    checkmate::assert_integerish(int_arr$n, all.missing = FALSE, lower = 0)
    checkmate::assert_integerish(int_arr$value, all.missing = FALSE,
                                 lower = 0, unique = TRUE)
    return(list(int_arr = int_arr, method = method))
  }
  int_arr <- checkmate::assert_integerish(
    int_arr,
    min.len = 2, lower = 0, upper = .Machine$integer.max,
    coerce = TRUE
  )
  checkmate::assert_flag(ignore_black)
  checkmate::assert(
    checkmate::check_flag(ignore_white),
    checkmate::check_number(ignore_white, lower = 0)
  )
  checkmate::assert_flag(ignore_na)
  if (all(is.na(int_arr))) {
    custom_stop(
      "`int_arr` must not be all `NA`s.",
      "Every element of your `int_arr` is `NA`."
    )
  }
  if (anyNA(int_arr)) {
    if (!ignore_na) {
      custom_stop(
        "
        The input `int_arr` has NA values, but you have `ignore_na = FALSE`, so
        the function `auto_thresh()` has errored.
        ",
        "
        To tell `auto_thresh()` to ignore `NA` values, set the argument
        `ignore_na = TRUE`.
        "
      )
    } else {
      int_arr <- int_arr[!is.na(int_arr)]
    }
  }
  checkmate::assert(
    checkmate::check_vector(int_arr, any.missing = FALSE),
    checkmate::check_array(int_arr, any.missing = FALSE)
  )
  if (ignore_black) int_arr[int_arr == 0] <- NA
  if (ignore_white) {
    if (isTRUE(ignore_white)) {
      mx <- max(int_arr)
      if (mx %in% (2^c(8, 12, 16, 32) - 1)) int_arr[int_arr == mx] <- NA
    } else {
      int_arr[int_arr >= ignore_white] <- NA
    }
  }
  list(int_arr = int_arr, method = method)
}

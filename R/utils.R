## Translate the fail argument from what the user selects to what failed pixels
## should be set to.
translate_fail <- function(arr, fail) {
  stopifnot(length(fail) == 1)
  if (is.na(fail)) return(NA)
  if (is.numeric(fail)) {
    stopifnot(fail >= 0)
  } else if (is.character(fail)) {
    fail <- filesstrings::match_arg(fail, c("saturate", "zero"),
                                   ignore_case = TRUE)
  }
  if (fail == "zero") {
    fail <- 0
  } else if (fail == "saturate") {
    mx <- max(arr, na.rm = TRUE)
    bits_per_sample <- 8
    if (mx > 2 ^ 16 - 1) {
      bits_per_sample <- 32
    } else if (mx > 2 ^ 8 - 1) {
      bits_per_sample <- 16
    }
    fail <- 2 ^ bits_per_sample - 1
  }
  fail
}

eval_text <- function(string) {
  checkmate::assert_scalar(string)
  checkmate::assert_character(string)
  eval(parse(text = string))
}


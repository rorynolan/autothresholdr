## Translate the fail argument from what the user selects to what failed pixels
## should be set to.
translate_fail <- function(arr, fail) {
  checkmate::assert_scalar(fail, na.ok = TRUE)
  if (is.na(fail)) {
    return(NA)
  }
  if (is.numeric(fail)) {
    if (fail < 0) {
      custom_stop(
        "
        If `fail` is specified as a number, then that number must be greater
        than zero.
        ",
        "You have specified `fail = {format(fail, scientific = FALSE)}`."
      )
    }
  } else if (is.character(fail)) {
    fail <- filesstrings::match_arg(fail, c("saturate", "zero"),
      ignore_case = TRUE
    )
  }
  if (fail == "zero") {
    fail <- 0
  } else if (fail == "saturate") {
    mx <- max(arr, na.rm = TRUE)
    bits_per_sample <- 8
    if (mx > 2^16 - 1) {
      bits_per_sample <- 32
    } else if (mx > 2^8 - 1) {
      bits_per_sample <- 16
    }
    fail <- 2^bits_per_sample - 1
  }
  fail
}

eval_text <- function(string) {
  checkmate::assert_scalar(string)
  checkmate::assert_character(string)
  eval(parse(text = string))
}

#' Construct the bullet point bits for `custom_stop()`.
#'
#' @param string The message for the bullet point.
#'
#' @return A string with the bullet-pointed message nicely formatted for the
#'   console.
#'
#' @noRd
custom_stop_bullet <- function(string) {
  checkmate::assert_string(string)
  string %<>% strwrap(width = 57)
  string[1] %<>% {
    glue::glue("    * {.}")
  }
  if (length(string) > 1) {
    string[-1] %<>% {
      glue::glue("      {.}")
    }
  }
  glue::glue_collapse(string, sep = "\n")
}

#' Nicely formatted error message.
#'
#' Format an error message with bullet-pointed sub-messages with nice
#' line-breaks.
#'
#' Arguments should be entered as `glue`-style strings.
#'
#' @param main_message The main error message.
#' @param ... Bullet-pointed sub-messages.
#'
#' @noRd
custom_stop <- function(main_message, ..., .envir = parent.frame()) {
  checkmate::assert_string(main_message)
  main_message %<>% glue::glue(.envir = .envir)
  out <- strwrap(main_message, width = 63)
  dots <- unlist(list(...))
  if (length(dots)) {
    if (!is.character(dots)) {
      stop("\nThe arguments in ... must all be of character type.")
    }
    dots %<>% purrr::map_chr(glue::glue, .envir = .envir) %>%
      purrr::map_chr(custom_stop_bullet)
    out %<>% {
      glue::glue_collapse(c(., dots), sep = "\n")
    }
  }
  rlang::abort(glue::glue("{out}"))
}

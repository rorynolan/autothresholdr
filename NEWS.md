# `autothresholdr` 1.4.2

## BUG FIXES
* Needed new compile with later version of `Rcpp` to avoid CRAN warning.


# `autothresholdr` 1.4.1

## BUG FIXES
* C++11 specification is now obsolete.


# `autothresholdr` 1.4.0

## NEW FEATURES
* Calculation of thresholds from frequency tables.


# `autothresholdr` 1.3.12

## BUG FIXES
* Bug fix for stack thresholding stacks with a single frame.


# `autothresholdr` 1.3.11

## BUG FIXES
* Calculated threshold was not correct for input arrays that did not contain zeros.


# `autothresholdr` 1.3.10

## BUG FIXES
* Remove `LazyData` from `DESCRIPTION` (was causing CRAN note).


# `autothresholdr` 1.3.9

## BUG FIXES
* Should insist on R >= 3.5 due to import of `strex` >= 1.4.


# `autothresholdr` 1.3.8

## BUG FIXES
* Fix a minor `NAMESPACE` issue.


# `autothresholdr` 1.3.7

## MINOR IMPROVEMENTS
* Lighten by importing `strex` rather than `filesstrings`.


# `autothresholdr` 1.3.6

## BUG FIXES
Cope with `ijtiff` not working on 32-bit windows.


# `autothresholdr` 1.3.5

## BUG FIXES
* Insist on bug-fixed `ijtiff` v2.0.2.


# `autothresholdr` 1.3.4

## BUG FIXES
* Insist on bug-fixed `filesstrings` v3.1.5.


# `autothresholdr` 1.3.3

## BUG FIXES
* Insist on updated, less buggy `filesstrings` and `ijtiff`.


# `autothresholdr` 1.3.2

## BUG FIXES
* Remove superfluous `stringr` from `Imports`.


# `autothresholdr` 1.3.1

## BUG FIXES
* Require necessary version of `glue`.
* Require debugged `filesstrings` 3.1.1.


# `autothresholdr` 1.3.0

## NEW FEATURES
* Better vignettes.
* A `pkgdown` website.

## MINOR IMPROVEMENTS
* Better error messages.

## BUG FIXES
* Insist on latest versions of `ijtiff` and `filesstrings` (which have important bug fixes).


# `autothresholdr` 1.2.1

## BUG FIXES
* For new versions of `filesstrings` and `ijtiff`.
* Update to `checkmate` broke the package so this is the fix.


# `autothresholdr` 1.2.0

## MINOR IMPROVEMENTS
* The package is now lighter by depending on `filesstrings` instead of `RSAGA`.


# `autothresholdr` 1.1.2

## BUG FIXES
* Ensure using latest version of `ijtiff`. Old version is buggy.


# `autothresholdr` 1.1.1

## BUG FIXES
* Fix some poor C++ typing.


# `autothresholdr` 1.1.0

## NEW FEATURES
* The package now has it's own S3 class system:
  - Class `th` for thresholds.
  - Class `threshed_arr` for thresholded arrays.
  - Class `stack_threshed_arr` for stack-thresholded arrays.
  - Class `arr_mask` for a mask of an array.
    
## MINOR IMPROVEMENTS
* The package no longer depends on `EBImage` package from Bioconductor. `EBImage` is a great package but CRAN packages are easier to install if they depend on CRAN packages only. Now `ijtiff` is used instead.

## DEPRECATED
* `can_be_integer()` is gone. Use `checkmate::check_integerish()` instead.
* Pillar statistics are no longer exported. Should you be looking for them, they are exported in the `detrendr` package.
    

# `autothresholdr` 1.0.0

## NEW FEATURES
* The `rJava` (and hence java) dependency has been removed. All functions which used to be in java are now done in `Rcpp`.

## MINOR IMPROVEMENTS
* The `fail` arguments of `auto_thresh_apply_mask()`, `mean_stack_thresh()` and `med_stack_thresh()` now work like the `na` argument of `nandb::WriteIntImage()`.
* `auto_thresh_mask()` and `auto_thresh_apply_mask()` now have the abbreviations `mask()` and `apply_mask()`.
* The functions now have an `ignore_na` argument for `NA` handling.

## BUG FIXES
* It is now the case that for a threshold *x*, values greater than or equal to *x* are deemed to "pass" the thresholding and values less than *x* are deemed to "fail" the thresholding. Before what was happening was that values greater than *x* were deemed to have passed and values less than or equal to *x* were deemed to have failed.


# `autothresholdr` 0.6.0

## NEW FEATURES
* There's a new thresholding method `"Huang2"` which is very similar to (but _not_ the same as and hence should not be assumed to give the same results as) `"Huang"` and is much faster when applied to 16-bit images.
* `mean_stack_thresh()` can now handle thresholds between 0 and 1.

## MINOR IMPROVEMENTS
* Use `ignore_black` and `ignore_white` instead of `ignore.black` and `ignore.white` to comply with tidyverse style guide.
* Add `ignore_black` and `ignore_white` options to `mean_stack_thresh()` and `med_stack_thresh()`.

## BUG FIXES
* Fix issues for Mean and Otsu methods concerning 16-bit images.


# `autothresholdr` 0.5.0

## MINOR IMPROVEMENTS
* Renamed all exported functions to be in `snake_case`.
* The skip.consts option in the stack_thresh functions is gone. Now these functions error if you pass them a constant array.


# `autothresholdr` 0.4.0

## MINOR IMPROVEMENTS
* Add `MeanStackThresh()` and `MedStackThresh()`.


# `autothresholdr` 0.3.0

## MINOR IMPROVEMENTS
* Add option to manually set threshold.
* Improve OSX installation instructions in README.md.


# `autothresholdr` 0.2.0

* The first CRAN-worthy version.

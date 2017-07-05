### 0.6.0

#### NEW FEATURES
* There's a new thresholding method `"Huang2"` which is very similar to (but _not_ the same as and hence should not be assumed to give the same results as) `"Huang"` and is much faster when applied to 16-bit images.
* `mean_stack_thresh()` can now handle thresholds between 0 and 1.

#### MINOR IMPROVEMENTS
* Use `ignore_black` and `ignore_white` instead of `ignore.black` and `ignore.white` to comply with tidyverse style guide.
* Add `ignore_black` and `ignore_white` options to `mean_stack_thresh()` and `med_stack_thresh()`.

#### BUG FIXES
* Fix issues for Mean and Otsu methods concerning 16-bit images.


### 0.5.0

#### MINOR IMPROVEMENTS
* Rename all exported functions to be in snake_case.
* The skip.consts option in the stack_thresh functions is gone.
  - Now these functions error if you pass them a constant array.


### 0.4.0

#### MINOR IMPROVEMENTS
* Add MeanStackThresh and MedStackThresh.


### 0.3.0

#### MINOR IMPROVEMENTS
* Add option to manually set threshold.
* Improve OSX installation instructions in README.md.


## autothresholdr 0.2.0

* The first CRAN-worthy version.

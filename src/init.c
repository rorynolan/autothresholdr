#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME:
  Check these declarations against the C/Fortran source code.
*/

  /* .Call calls */
  extern SEXP autothresholdr_mean_pillars(SEXP);
extern SEXP autothresholdr_median_pillars(SEXP);
extern SEXP autothresholdr_RcppExport_registerCCallable();
extern SEXP autothresholdr_var_pillars(SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"autothresholdr_mean_pillars",                 (DL_FUNC) &autothresholdr_mean_pillars,                 1},
  {"autothresholdr_median_pillars",               (DL_FUNC) &autothresholdr_median_pillars,               1},
  {"autothresholdr_RcppExport_registerCCallable", (DL_FUNC) &autothresholdr_RcppExport_registerCCallable, 0},
  {"autothresholdr_var_pillars",                  (DL_FUNC) &autothresholdr_var_pillars,                  1},
  {NULL, NULL, 0}
};

void R_init_autothresholdr(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}

#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME:
Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP autothresholdr_MeanPillars(SEXP);
extern SEXP autothresholdr_MedianPillars(SEXP);
extern SEXP autothresholdr_RcppExport_registerCCallable();
extern SEXP autothresholdr_VarPillars(SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"autothresholdr_MeanPillars",                  (DL_FUNC) &autothresholdr_MeanPillars,                  1},
  {"autothresholdr_MedianPillars",                (DL_FUNC) &autothresholdr_MedianPillars,                1},
  {"autothresholdr_RcppExport_registerCCallable", (DL_FUNC) &autothresholdr_RcppExport_registerCCallable, 0},
  {"autothresholdr_VarPillars",                   (DL_FUNC) &autothresholdr_VarPillars,                   1},
  {NULL, NULL, 0}
};

void R_init_autothresholdr(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}

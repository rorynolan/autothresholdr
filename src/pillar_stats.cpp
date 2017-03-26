#include <Rcpp.h>
using namespace Rcpp;

//' Get the means/medians/variances of pillars of a 3d array
//'
//' For a 3-dimensional array \code{mat3d}, pillar \code{ij} is defined as
//' \code{mat3d[i, j, ]}. These functions compute the mean, median and variance of each
//' pillar.
//'
//' @param mat3d A 3-dimensional array.
//'
//' @return A matrix where element \code{i,j} is equal to \code{mean(mat3d[i, j, ])},
//' \code{median(mat3d[i, j, ])}, or \code{var(mat3d[i, j, ])}.
//'
//' @examples
//' m3 <- array(1:16, dim = c(2, 2, 4))
//' MeanPillars(m3)
//' MedianPillars(m3)
//' VarPillars(m3)
//'
//' @export
// [[Rcpp::export]]
NumericMatrix MeanPillars(NumericVector mat3d) {
  IntegerVector dim = mat3d.attr("dim");
  int n_pillars = dim[0] * dim[1];
  int pillar_len = dim[2];
  NumericMatrix means(dim[0], dim[1]);
  double mean_i;
  NumericVector pillar_i(pillar_len);
  for (int i = 0; i < n_pillars; i++) {
    for (int j = 0; j < pillar_len; j++) {
      pillar_i[j] = mat3d[i + j * n_pillars];
    }
    mean_i = mean(pillar_i);
    means(i % dim[0], i / dim[0]) = mean_i;
  }
  return means;
}

//' @rdname MeanPillars
//' @export
// [[Rcpp::export]]
NumericMatrix VarPillars(NumericVector mat3d) {
  IntegerVector dim = mat3d.attr("dim");
  int n_pillars = dim[0] * dim[1];
  int pillar_len = dim[2];
  NumericMatrix vars(dim[0], dim[1]);
  double var_i;
  NumericVector pillar_i(pillar_len);
  for (int i = 0; i < n_pillars; i++) {
    for (int j = 0; j < pillar_len; j++) {
      pillar_i[j] = mat3d[i + j * n_pillars];
    }
    var_i = var(pillar_i);
    vars(i % dim[0], i / dim[0]) = var_i;
  }
  return vars;
}

//' @rdname MeanPillars
//' @export
// [[Rcpp::export]]
NumericMatrix MedianPillars(NumericVector mat3d) {
  IntegerVector dim = mat3d.attr("dim");
  int n_pillars = dim[0] * dim[1];
  int pillar_len = dim[2];
  NumericMatrix meds(dim[0], dim[1]);
  double med_i;
  NumericVector pillar_i(pillar_len);
  for (int i = 0; i < n_pillars; i++) {
    for (int j = 0; j < pillar_len; j++) {
      pillar_i[j] = mat3d[i + j * n_pillars];
    }
    med_i = median(pillar_i);
    meds(i % dim[0], i / dim[0]) = med_i;
  }
  return meds;
}

#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::interfaces(r, cpp)]]

//' Get the sums/means/medians/variances of pillars of a 3d array.
//'
//' For a 3-dimensional array \code{arr3d}, pillar \code{ij} is defined as
//' \code{arr3d[i, j, ]}. These functions compute the mean, median and variance
//' of each pillar.
//'
//' @param arr3d A 3-dimensional array.
//'
//' @return A matrix where element \code{i,j} is equal to
//' \code{sum(arr3d[i, j, ])}, \code{mean(arr3d[i, j, ])},
//' \code{median(arr3d[i, j, ])}, or \code{var(arr3d[i, j, ])}.
//'
//' @examples
//' m3 <- array(1:16, dim = c(2, 2, 4))
//' mean_pillars(m3)
//' median_pillars(m3)
//' var_pillars(m3)
//'
//' @export
// [[Rcpp::export]]
NumericMatrix sum_pillars(NumericVector arr3d) {
  IntegerVector dim = arr3d.attr("dim");
  int n_pillars = dim[0] * dim[1];
  int pillar_len = dim[2];
  NumericMatrix sums(dim[0], dim[1]);
  double sum_i;
  NumericVector pillar_i(pillar_len);
  for (int i = 0; i < n_pillars; i++) {
    for (int j = 0; j < pillar_len; j++) {
      pillar_i[j] = arr3d[i + j * n_pillars];
    }
    sum_i = sum(pillar_i);
    sums(i % dim[0], i / dim[0]) = sum_i;
  }
  return sums;
}

//' @rdname sum_pillars
//' @export
// [[Rcpp::export]]
NumericMatrix mean_pillars(NumericVector arr3d) {
  IntegerVector dim = arr3d.attr("dim");
  int n_pillars = dim[0] * dim[1];
  int pillar_len = dim[2];
  NumericMatrix means(dim[0], dim[1]);
  double mean_i;
  NumericVector pillar_i(pillar_len);
  for (int i = 0; i < n_pillars; i++) {
    for (int j = 0; j < pillar_len; j++) {
      pillar_i[j] = arr3d[i + j * n_pillars];
    }
    mean_i = mean(pillar_i);
    means(i % dim[0], i / dim[0]) = mean_i;
  }
  return means;
}

//' @rdname sum_pillars
//' @export
// [[Rcpp::export]]
NumericMatrix var_pillars(NumericVector arr3d) {
  IntegerVector dim = arr3d.attr("dim");
  int n_pillars = dim[0] * dim[1];
  int pillar_len = dim[2];
  NumericMatrix vars(dim[0], dim[1]);
  double var_i;
  NumericVector pillar_i(pillar_len);
  for (int i = 0; i < n_pillars; i++) {
    for (int j = 0; j < pillar_len; j++) {
      pillar_i[j] = arr3d[i + j * n_pillars];
    }
    var_i = var(pillar_i);
    vars(i % dim[0], i / dim[0]) = var_i;
  }
  return vars;
}

//' @rdname sum_pillars
//' @export
// [[Rcpp::export]]
NumericMatrix median_pillars(NumericVector arr3d) {
  IntegerVector dim = arr3d.attr("dim");
  int n_pillars = dim[0] * dim[1];
  int pillar_len = dim[2];
  NumericMatrix meds(dim[0], dim[1]);
  double med_i;
  NumericVector pillar_i(pillar_len);
  for (int i = 0; i < n_pillars; i++) {
    for (int j = 0; j < pillar_len; j++) {
      pillar_i[j] = arr3d[i + j * n_pillars];
    }
    med_i = median(pillar_i);
    meds(i % dim[0], i / dim[0]) = med_i;
  }
  return meds;
}

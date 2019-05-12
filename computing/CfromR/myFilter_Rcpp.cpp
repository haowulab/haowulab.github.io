#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector myFilter_Rcpp( NumericVector x, NumericVector f ) {
	int nx = x.length(), nf = f.length();
	int i, j;
	double tmp;
	NumericVector result(nx);
	
	int half_nf = (nf+1)/2;
	for(i=half_nf-1; i<nx - half_nf; i++) {
		tmp = 0.0;
		for(j=0; j<nf; j++) {
			tmp += x[i-half_nf+1+j]*f[j];
		}
		result[i] = tmp;
	}
	return(result);
}



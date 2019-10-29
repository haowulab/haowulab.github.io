#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector myRowSum( NumericMatrix x ) {
	int nrow = x.nrow(), ncol = x.ncol();
	int i, j;
	double tmp;
	NumericVector result(nrow);

	for(i=0; i<nrow; i++) {
		tmp = 0.0;
		for(j=0; j<ncol; j++) 
			tmp = tmp + x(i,j);
		result[i] = tmp;
	}
	return(result);
}


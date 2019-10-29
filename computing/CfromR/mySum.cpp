
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
double mySum(NumericVector x) {
	int i;
	double result=0.0;

	for(i=0; i<x.size(); i++) 
		result = result + x[i];
	return(result);
}

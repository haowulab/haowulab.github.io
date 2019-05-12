#include <R.h>
#include <Rinternals.h>

SEXP myFilter_Call( SEXP x, SEXP f ) {
	int nx = length(x), nf = length(f); 
	int i, j;
	double tmp;

	SEXP result = PROTECT( allocVector(REALSXP, nx) );
	double *result_ptr = REAL(result);
	double *x_ptr = REAL(x), *f_ptr = REAL(f);

	int half_nf = (nf+1)/2;
	for(i=half_nf-1; i<nx - half_nf; i++) {
		tmp = 0.0;
		for(j=0; j<nf; j++) {
			tmp += x_ptr[i-half_nf+1+j] * f_ptr[j];
		}
		result_ptr[i] = tmp;
	}
	UNPROTECT(1);
	return(result);
}



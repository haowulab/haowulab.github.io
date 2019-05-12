
#include <stdio.h>
#include <R.h>
#include <Rinternals.h>

void myRowSum_C(double *x, int *nrowx, int *ncolx, double *result) {
	int i, j;
	
	for(i=0; i<nrowx[0]; i++) 
		for(j=0; j<ncolx[0]; j++) 
			result[i] = result[i] + x[j*nrowx[0]+i];
}

SEXP myRowSum_Call(SEXP X) {
	int i, j, nrowx, ncolx;
	double *x_ptr;

	/* extract the "dim" attribute */
	SEXP dims;
	dims = getAttrib( X, R_DimSymbol ) ;
	nrowx = INTEGER(dims)[0];
	ncolx = INTEGER(dims)[1];
	x_ptr = REAL(X); 

	/* allocate memory for the result vector */
	SEXP result = PROTECT( allocVector(REALSXP, nrowx) );
	double *result_ptr = REAL(result);

	for(i=0; i<nrowx; i++)  {
		result_ptr[i] = 0.0;
		for(j=0; j<ncolx; j++) 
			result_ptr[i] = result_ptr[i] + x_ptr[j*nrowx+i];
	}
	UNPROTECT(1);
	return(result);
}


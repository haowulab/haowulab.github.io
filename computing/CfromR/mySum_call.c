#include <stdio.h>
#include <R.h>
#include <Rinternals.h>

SEXP mySum_call(SEXP Rx) {
	int i, nx;
	nx = length(Rx);
	
	/* allocate and initialize memory for result */
	SEXP result = PROTECT( allocVector(INTSXP, 1) );
	int *result_ptr = INTEGER(result);
	result_ptr[0] = 0;

	/* take out the values from input */
	int *x = INTEGER(Rx); 

	/* compute the sum */
	for(i=0; i<nx; i++) 
		result_ptr[0] = result_ptr[0] + x[i];

	UNPROTECT(1);
	return(result);
}


#include <R.h>
#include <Rinternals.h>
#include <R_ext/BLAS.h>

SEXP matmult(SEXP X, SEXP Y) {
	int nrowX, ncolX, ncolY;
	double *x_ptr, *y_ptr, *result_ptr;

	/* extract the "dim" attribute */
	SEXP dims; 
	dims = getAttrib( X, R_DimSymbol ) ;
	nrowX = INTEGER(dims)[0];
	ncolX = INTEGER(dims)[1];
	dims = getAttrib( Y, R_DimSymbol ) ;
	ncolY = INTEGER(dims)[1];

	/* allocate memory for the result matrix */
	SEXP result = PROTECT( allocVector(REALSXP, nrowX*ncolY) );
	
	/* get pointers for the input/output */
	x_ptr = REAL(X); 
	y_ptr = REAL(Y);
	result_ptr = REAL(result);

	/* call dgemm function to multiple two matrices */
	double one = 1.0;
	double zero = 0.0;
	F77_CALL(dgemm)("n", "n", &nrowX, &ncolY, &ncolX, &one, x_ptr, &nrowX, y_ptr, &ncolX,
					&zero, result_ptr, &nrowX);
	
	/* manipulate the output to make it a matrix */
	dims = PROTECT( allocVector(INTSXP, 2) );
	INTEGER(dims)[0] = nrowX;
	INTEGER(dims)[1] = ncolY;
	setAttrib( result, R_DimSymbol, dims ) ;
	
	UNPROTECT(2);
	return(result);
}


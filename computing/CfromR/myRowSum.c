
#include <stdio.h>

void myRowSum(int *x, int *nrowx, int *ncolx, int *result) {
	int i, j;
	
	for(i=0; i<nrowx[0]; i++) 
		for(j=0; j<ncolx[0]; j++) 
			result[i] = result[i] + x[j*nrowx[0]+i];
}


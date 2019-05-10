#include <stdio.h>

void mySum2(int *x, int *nx, int *result) {
	int i;
	for(i=0; i<nx[0]; i++) 
		result[0] = result[0] + x[i];
}

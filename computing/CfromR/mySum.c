#include <stdio.h>

void mySum(int *x, int *nx) {
	int i, result=0;
	for(i=0; i<nx[0]; i++) 
		result = result + x[i];
	printf ("%d\n", result);
}

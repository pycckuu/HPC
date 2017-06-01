/*
 * numerical integration example - serial code to computer pi
 *
 * compute pi by approximating the area under the curve f(x) = 4 / (1 + x*x)
 * between 0 and 1.
 *
 */
#include <stdio.h>
#define NBIN 100000

int main() {
	int i; 
	double step,x,sum=0.0,pi;

	step = 1.0/NBIN;

	for (i=0; i<NBIN; i++) {
		x = (i+0.5)*step;
		sum += 4.0/(1.0+x*x);
	}
	pi = sum*step;
	printf("PI = %f\n",pi);
}

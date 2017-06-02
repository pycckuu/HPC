#include<math.h>
#include<stdio.h>

int main() {

//int const n=100000,niter=500;
    int const n = 100000, niter = 2000;

    double x[n], u[n], udt[n];
    int i, iter;
    double dx = 1.0;
    double kappa = 0.1;

    FILE *fp;
    fp = fopen("out.txt", "w");


    for (i = 0; i < n; i++) {
        u[i] = exp(-pow(dx * (i - n / 2.0), 2.0) / 100000.0);
        udt[i] = 0.0;
        fprintf(fp, " %lf \n", u[i]);
    }

    fclose(fp);


    for (iter = 0; iter < niter; iter++) {

        for (i = 1; i < n - 1; i++) {
            udt[i] = u[i] + kappa * (u[i + 1] + u[i - 1] - 2 * u[i]);
        }

        for (i = 0; i < n; i++) {
            u[i] = udt[i];
        }

    }


    fp = fopen("final.txt", "w");
    for (i = 0; i < n; i++) {
        fprintf(fp, " %lf \n", u[i]);
    }
    fclose(fp);




    return 0;
}






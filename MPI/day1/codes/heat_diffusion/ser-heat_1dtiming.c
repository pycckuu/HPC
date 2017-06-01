
/*
 * heat diffusion example, as discussed in textbook.
 *
 * command line arguments are number of points, maximum number of
 *   iterations, and convergence threshold.
 *
 * sequential version, using MPI timing function.
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <mpi.h>

#define LEFTVAL 1.0
#define RIGHTVAL 10.0

void initialize(double uk[], double ukp1[], int nx) {
    int i;
    uk[0] = LEFTVAL; uk[nx-1] = RIGHTVAL;
    for (i = 1; i < nx-1; ++i)
        uk[i] = 0.0;
    for (i = 0; i < nx; ++i)
        ukp1[i] = uk[i];
}

int main(int argc, char *argv[]) {

    int nx;
    int maxsteps;
    double threshold;

    double *uk; 
    double *ukp1;
    double *temp; 
    double dx, dt;
    double start_time, end_time;
    double maxdiff;
    int step, i;

    int numProcs, myID;

    /* MPI initialization */
    MPI_Init(&argc, &argv);
    MPI_Comm_size (MPI_COMM_WORLD, &numProcs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myID);

    if (argc < 4) {
        fprintf(stderr, 
                "usage is %s points max_iterations convergence_threshold\n", 
                argv[0]);
        MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }

    start_time = MPI_Wtime();

    nx = atoi(argv[1]);
    maxsteps = atoi(argv[2]);
    threshold = atof(argv[3]);
    uk = malloc(sizeof(double) * nx);
    ukp1 = malloc(sizeof(double) * nx);
    if (!uk || !ukp1) {
        fprintf(stderr, "Unable to allocate memory\n");
        return EXIT_FAILURE;
    }
    dx = 1.0/nx;
    dt = 0.5*dx*dx;
    maxdiff = threshold;

    initialize(uk, ukp1, nx);

    for (step = 0; (step < maxsteps) && (maxdiff >= threshold); ++step) {

        double diff;

        /* compute new values */
        for (i = 1; i < nx-1; ++i) {
          ukp1[i]=uk[i]+ (dt/(dx*dx))*(uk[i+1]-2*uk[i]+uk[i-1]);
        }

        /* check for convergence */
        maxdiff = 0.0;
        for (i = 1; i < nx-1; ++i) {
            diff = fabs(uk[i] - ukp1[i]);
            if (diff > maxdiff) maxdiff = diff;
        }

        /* "copy" ukp1 to uk by swapping pointers */
        temp = ukp1; ukp1 = uk; uk = temp;
    }

    end_time = MPI_Wtime();
    printf("sequential program:\n");
    printf("nx = %d, maxsteps = %d, threshold = %g\n", nx, maxsteps, threshold);
    if (maxdiff < threshold) {
        printf("converged in %d iterations\n", step);
    }
    else {
        printf("failed to converge in %d iterations, maxdiff = %g\n", 
                step, maxdiff);
    }
    printf("execution time = %g\n", end_time - start_time);

    /* clean up and end */
    MPI_Finalize();
    return EXIT_SUCCESS;
}


/*
 * heat diffusion example, as discussed in the slides.
 *
 * command line arguments are number of points, maximum number of
 *   iterations, and convergence threshold.
 *
 * parallel version with MPI.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <mpi.h>

#define LEFTVAL 1.0
#define RIGHTVAL 10.0

/* uk, ukp1 include "ghost cell" at each end */
void initialize(double uk[], double ukp1[], int numPoints, 
        int numProcs, int myID) {
    int i;
    for (i = 1; i <= numPoints; ++i)
        uk[i] = 0.0;
    /* left endpoint */
    if (myID == 0)
        uk[1] = LEFTVAL;
    /* right endpoint */
    if (myID == numProcs-1)
        uk[numPoints] = RIGHTVAL;
    /* copy values to ukp1 */
    for (i = 1; i <= numPoints; ++i)
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

    int numProcs, myID, leftNbr, rightNbr;
    int numPoints;
    MPI_Status status; 

    /* MPI initialization */
    MPI_Init(&argc, &argv);
    MPI_Comm_size (MPI_COMM_WORLD, &numProcs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myID);

    if (argc < 4) {
      fprintf(stderr,"usage is %s points max_iterations convergence_threshold\n", argv[0]); 
      MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }

    MPI_Barrier(MPI_COMM_WORLD);
    start_time = MPI_Wtime();

    nx = atoi(argv[1]);
    maxsteps = atoi(argv[2]);
    threshold = atof(argv[3]);
    dx = 1.0/nx;
    dt = 0.5*dx*dx;
    maxdiff = threshold;

    if ((nx % numProcs) != 0) {
      fprintf(stderr, "Number of processes must evenly divide %d\n", nx);
      MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }

    leftNbr = myID - 1; /* ID of left "neighbor" process */
    rightNbr = myID + 1; /* ID of right "neighbor" process */
    numPoints = (nx / numProcs);
    /* uk, ukp1 include a "ghost cell" at each end */
    uk = malloc(sizeof(double) * (numPoints+2));
    ukp1 = malloc(sizeof(double) * (numPoints+2));
    if (!uk || !ukp1) {
      fprintf(stderr, "Unable to allocate memory\n");
      MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }

    initialize(uk, ukp1, numPoints, numProcs, myID);

    for (step = 0; (step < maxsteps) && (maxdiff >= threshold); ++step) {

      double diff, maxdiff_local = 0.0;

      /* exchange boundary information */









      /* compute new values for interior points */
      for (i = 2; i < numPoints; ++i) {
        ukp1[i]=uk[i]+ (dt/(dx*dx))*(uk[i+1]-2*uk[i]+uk[i-1]);
      }

      /* compute new values for boundary points 
       * (no real need to do these separately, but it would allow us to
       * later overlap computation and communication with fewer code changes)
       */
        



      /* check for convergence */
      maxdiff_local = 0.0;
      for (i = 1; i <= numPoints; ++i) {
         diff = fabs(uk[i] - ukp1[i]);
         if(diff > maxdiff_local) 
           maxdiff_local = diff;
      }
      MPI_Allreduce(&maxdiff_local, &maxdiff, 1, MPI_DOUBLE, MPI_MAX, MPI_COMM_WORLD);

      /* "copy" ukp1 to uk by swapping pointers */
      temp = ukp1; ukp1 = uk; uk = temp;
    }

    MPI_Barrier(MPI_COMM_WORLD); /* sloppy -- to get more meaningful timing */
    end_time = MPI_Wtime();
    if (myID == 0) {
    printf("MPI program (%d processes):\n", numProcs);
    printf("nx = %d, maxsteps = %d, threshold = %g\n", nx, maxsteps, threshold);
    if (maxdiff < threshold) {
        printf("converged in %d iterations\n", step);
    }
    else {
     printf("failed to converge in %d iterations, maxdiff = %g\n", 
                step, maxdiff);
    }
    printf("execution time = %g\n", end_time - start_time);
    }
 
    /* clean up and end */
    MPI_Finalize();
    return EXIT_SUCCESS;
}


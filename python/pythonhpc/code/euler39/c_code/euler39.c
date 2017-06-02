#include <stdio.h>
#include <sys/time.h>
#include <time.h>

// accurate timing function
int timeval_subtract (double *result, struct timeval *x, struct timeval *y) {
    struct timeval result0;

    /* Perform the carry for the later subtraction by updating y. */
    if (x->tv_usec < y->tv_usec) {
        int nsec = (y->tv_usec - x->tv_usec) / 1000000 + 1;
        y->tv_usec -= 1000000 * nsec;
        y->tv_sec += nsec;
    }
    if (x->tv_usec - y->tv_usec > 1000000) {
        int nsec = (y->tv_usec - x->tv_usec) / 1000000;
        y->tv_usec += 1000000 * nsec;
        y->tv_sec -= nsec;
    }

    /* Compute the time remaining to wait.
 *      tv_usec is certainly positive. */
    result0.tv_sec = x->tv_sec - y->tv_sec;
    result0.tv_usec = x->tv_usec - y->tv_usec;
    *result = ((double)result0.tv_usec)/1e6 + (double)result0.tv_sec;

    /* Return 1 if result is negative. */
    return x->tv_sec < y->tv_sec;
}

int find_num_solutions(int p){
    int a,b,c,n;
    n=0;
    for(a=1;a<p/2;a++){
        for (b=a;b<p/2;b++){
            c=p-a-b;
            if(a*a+b*b==c*c){
                n=n+1;
            }
        }
    }
return n;
}

int main(){

// variables needed for timing
    double restime;
    struct timeval  tdr0, tdr1;

    int i;
    int nrange;
    int nsols;
    int nmax,imax;
    nrange=1000;
//nrange=5000;
    nmax=0;
    imax=0;

    gettimeofday (&tdr0, NULL);
    for (i=0;i<nrange;i++){
        nsols=find_num_solutions(i);
        if(nsols>nmax){
            nmax=nsols;
            imax=i;
        }
    }

    gettimeofday (&tdr1, NULL);
    timeval_subtract (&restime, &tdr1, &tdr0);
    printf ("cpu time %f s\n", restime);

    printf("imax=%d nmax=%d \n",imax,nmax);
    return 0;
}


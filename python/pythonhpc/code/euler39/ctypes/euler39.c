#include <stdio.h>

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

int i;
int nrange;
int nsols;
int nmax,imax;
//nrange=1000;
nrange=5000;
nmax=0;
imax=0;


for (i=0;i<nrange;i++){
    nsols=find_num_solutions(i);
    if(nsols>nmax){
        nmax=nsols;
        imax=i;
    }
}

printf("imax=%d nmax=%d \n",imax,nmax);
return 0;
}


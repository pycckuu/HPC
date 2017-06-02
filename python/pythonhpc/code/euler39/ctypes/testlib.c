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

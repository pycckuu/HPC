
#include <stdio.h>
#define max_rows 10000

int array[max_rows];

int main(int argc, char *argv[])
{
   int i, num_rows;
   long int sum;

   // printf("please enter the number of numbers to sum: ");
   // scanf("%d", &num_rows);
   num_rows = 11;

   if (num_rows > max_rows) {
      printf("Too many numbers.\n");
      return 1;
   }

   /* initialize an array */

   for (i = 0; i < num_rows; i++) {
      array[i] = i;
   }

   /* compute sum */

   sum = 0;
   for (i = 0; i < num_rows; i++) {
      sum += array[i];
   }

   printf("The grand total is: %ld\n", sum);
}

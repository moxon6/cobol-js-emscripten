#include <stdio.h>

     int
     say(char *hello, char *world)
     {
       int i;
       for (i = 0; i < 6; i++)
         putchar(hello[i]);
       for (i = 0; i < 6; i++)
         putchar(world[i]);
       putchar('\n');
       return 0;
     }
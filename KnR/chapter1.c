/************
 * CHAPTER 1
 ************/

#include <stdio.h>
int main ()
{
  printf("hello, world\n");
}

// ----------------------------------------------------------------

#include <stdio.h>
/* print Fahrenheit-Celsius table for fahr = 0, 20, ..., 300*/
int main()
{
  int fahr, celsius;
  int lower, upper, step;
  lower = 0;   /* lower limit of temperature table */
  upper = 300; /* upper limit */
  step = 20;   /* step size */
  fahr = lower;
  while (fahr <= upper) {
    celsius = 5 * (fahr-32) / 9;
    printf("%d\t%d\n", fahr, celsius);
    fahr = fahr + step;
  }
}

// ----------------------------------------------------------------

#include <stdio.h>
/* print Fahrenheit-Celsius table for fahr=0,20,...,300; floating-point version */
int main()
{
  float fahr, celsius; int lower, upper, step;
  lower=0;   /* lower limit of temperature table*/
  upper=300; /* upperlimit*/
  step=20;   /*stepsize*/
  fahr = lower;
  while (fahr <= upper) {
    celsius = (5.0/9.0) * (fahr-32.0);
    printf("%3.0f %6.1f\n", fahr, celsius);
    fahr = fahr + step;
  }
}

// ----------------------------------------------------------------

#include <stdio.h>
/* print Fahrenheit-Celsius table */
int main()
{
  int fahr;
  for (fahr = 0; fahr <= 300; fahr = fahr + 20)
    printf("%3d %6.1f\n", fahr, (5.0/9.0) * (fahr-32));
}

// ----------------------------------------------------------------

#include <stdio.h>

#define LOWER 0   /* lower limit of table */
#define UPPER 300 /* upper limit */
#define STEP 20   /* step size */

/* print Fahrenheit-Celsius table */
int main ()
{
  int fahr;
  for (fahr = LOWER; fahr <= UPPER; fahr = fahr+ STEP)
    printf("%3d %6.1f\n", fahr, (5.0/9.0) * (fahr-32));
}

// ----------------------------------------------------------------

#include <stdio.h>
/* copy input to output; 1st version */
int main( )
{
  int c;
  c = getchar();
  while (c != EOF) {
    putchar(c);
    c = getchar();
  }
}

// ----------------------------------------------------------------

#include <stdio.h>
/* copy input to output; 2st version */
int main( )
{
  int c;
  while ((c = getchar()) != EOF)
    putchar(c);
}

// ----------------------------------------------------------------

#include <stdio.h>

/* count characters in input; 1st version */
int main()
{
  long nc;

  nc = 0;
  while (getchar() != EOF)
    ++nc;
  printf("%ld\n", nc);
}

// ----------------------------------------------------------------

#include <stdio.h>

/* count characters in input; 2nd version */
int main()
{
  double nc;

  for (nc = 0; getchar() != EOF; ++nc)
    ;
  printf("%.0f\n", nc);
}

// ----------------------------------------------------------------

#include <stdio.h>

/* count lines in input */
int main()
{
  int c, nl;

  nl = 0;
  while ((c = getchar()) != EOF)
    if (c == '\n')
      ++nl;
  printf("%d\n", nl);
}

// ----------------------------------------------------------------

#include <stdio.h>

#define IN  1 /* inside a word */
#define OUT 0 /* outside a word */

/* count lines, words, and characters in input */
int main()
{
  int c, nl, nw, nc, state;
  state = OUT;
  nl = nw = nc = 0;
  while ((c = getchar()) != EOF) {
    ++nc;
    if(c =='\n')
      ++nl;
    if(c == ' ' || c== '\n' || c== '\t')
      state = OUT;
    else if (state == OUT) {
      state = IN;
      ++nw;
    }
  }
  printf("%d %d %d\n", nl, nw, nc);
}

// ----------------------------------------------------------------

#include <stdio.h>

/* count digits, white space, others */
int main ()
{
  int c, i, nwhite, nother;
  int ndigit [10];

  nwhite = nother = 0;
  for (i = 0; i < 10; ++i)
    ndigit[i] = 0;

  while ((c = getchar()) != EOF)
    if (c >= '0' && c <= '9')
      ++ndigit[c-'0'];
    else if (c == ' ' || c == '\n' || c == '\t')
      ++nwhite;
    else
      ++nother;

  printf("digits =");
  for (i = 0; i < 10; ++i)
    printf (" %d", ndigit[i]);
  printf(", white space = %d, other = %d\n",
         nwhite, nother);
}

// ----------------------------------------------------------------

#include <stdio.h>

int power(int m, int n);

/* test power function */
int main ()
{
  int i;
  for (i = 0; i < 10; ++i)
    printf("%d %d %d\n", i, power(2,i), power(-3,i));
  return 0;
}

/* power: raise base to n-th power; n >= 0 */
int power(int base, int n)
{
  int i, p;
  p = 1;
  for (i = 1; i <= n; ++i)
    p = p * base;
  return p;
}

// ----------------------------------------------------------------

/* power: raise base to n-th power; n >= 0; version 2 */
int power(int base, int n)
{
  int p;
  for (p = 1; n > 0; --n)
    p = p * base;
  return p;
}

// ----------------------------------------------------------------

#include <stdio.h>

#define MAXLINE 1000 /* maximum input line length */

int get_line(char line[], int maxline);
void copy(char to[], char from[]);

/* print the longest input line */
int main()
{
  int len;               /* current line length */
  int max;               /* maximum length seen so far */
  char line[MAXLINE];    /* current input line */
  char longest[MAXLINE]; /* longest line saved here */

  max = 0;
  while ((len = get_line(line, MAXLINE)) > 0)
    if (len > max) {
      max = len;
      copy(longest, line);
    }
  if (max > 0) /* there was a line */
    printf("%s", longest);
  return 0;
}

/* get_line: read a line into s, return length */
int get_line(char s[],int lim)
{
  int c, i;
  for (i=0; i < lim-1 && (c=getchar())!=EOF && c!='\n'; ++i)
    s [i] = c;
  if (c == '\n') {
    s [i] = c;
    ++i;
  }
  s[i] = '\0' ;
  return i;
}

/* copy: copy 'from' into 'to'; assume to is big enough */
void copy(char to[], char from[])
{
  int i;
  i = 0;
  while ((to[i] = from[i]) != '\0')
    ++i;
}

// ----------------------------------------------------------------

#include <stdio.h>

#define MAXLINE 1000   /* maximum input line size */

int max;               /* maximum length seen so far */
char line[MAXLINE];    /* current input line */
char longest[MAXLINE]; /* longest line saved here */

int get_line(void);
void copy(void);

/* print longest input line; specialized version */
int main()
{
  int len;
  extern int max;
  extern char longest[];

  max = 0;

  while ((len = get_line()) > 0)
    if (len > max) {
      max = len;
      copy();
    }

  if (max > 0) /* there was a line */
    printf("%s", longest);
  return 0;
}

/* get_line: specialized version */
int get_line(void)
{
  int c, i;
  extern char line[];
  for (i = 0; i < MAXLINE - 1
         && (c=getchar()) != EOF && c != '\n'; ++i)
    line[i] = c;

  if (c == '\n') {
    line[i] = c;
    ++i;
  }

  line [ i] = '\0' ;
  return i;
}

/* copy: specialized version */
void copy(void)
{
  int i;
  extern char line[], longest[];

  i = 0;
  while ((longest[i] = line[i]) != '\0')
    ++i ;
}

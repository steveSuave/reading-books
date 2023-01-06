/************
 * CHAPTER 3
 ************/

/* binsearch: find x in v[0] <= v[l] <= ... <= v[n-l] */
int binsearch(int x, int v[], int n)
{
  int low, high, mid;

  low = 0;
  high = n - 1;
  while (low <= high) {
    mid = (low + high) / 2;
    if (x < v[mid])
      high = mid - 1;
    else if (x > v[mid])
      low = mid + 1;
    else /* found match */
      return mid;
  }
  return -1; /* no match */
}


// ----------------------------------------------------------------

#include <stdio.h>

int main () /* count digits, white space, others */
{
  int c, i, nwhite, nother, ndigit[10];

  nwhite = nother = 0;
  for (i = 0; i < 10; i++)
    ndigit[i] = 0;
  while ((c = getchar()) != EOF) {
    switch (c) {
    case 'O': case '1' : case '2' : case '3' : case '4' :
    case '5' : case '6' : case '7' : case '8' : case '9' :
      ndigit[c-'0']++;
      break;
    case ' ' :
    case '\n':
    case '\t' :
      nwhite++;
      break;
    default:
      nother++;
      break;
    }
  }
  printf("digits =");
  for (i = 0; i < 10; i++)
    printf(" %d", ndigit [i]);
  printf(", white space = %d, other = %d\n",
         nwhite, nother);
  return 0;
}


// ----------------------------------------------------------------

#include <ctype.h>
/* atoi: convert s to integer; version 2 */
int atoi(char s[])
{
  int i, n, sign;
  for (i =0; isspace(s[i]); i++) /* skip white space */
    ;
  sign=(s[i] == '-')? -1 : 1;
  if (s[i] == '+' || s[i] == '-') /* skip sign */
    i++;
  for (n - 0; isdigit(s[i]); i++)
    n=10 * n + (s[i]- '0');
  return sign * n;
}


// ----------------------------------------------------------------

/* shellsort: sort v[0]...v[n-1] into increasing order */
void shellsort(int v[], int n)
{
  int gap, i, j, temp;

  for (gap = n/2; gap > 0; gap /= 2)
    for (i = gap; i < n; i++)
      for (j=i-gap; j>=0 && v[j]>v[j+gap]; j-=gap) {
        temp = v[j];
        v[j] = v[j+gap];
        v[j+gap] = temp;
      }
}


// ----------------------------------------------------------------

/* itoa: convert n to characters in s */
void itoa(int n, char s[])
{
  int i, sign;

  if ((sign = n) < 0)      /* record sign */
    n = -n;                /* make n positive */
  i = 0;
  do {                     /* generate digits in reverse order */
    s[i++] = n % 10 + '0'; /* get next digit */
  } while ((n /= 10) > 0); /* delete it */
  if (sign < 0)
    s[i++] = '-';
  s[i] = '\0';
  reverse(s);
}


// ----------------------------------------------------------------

/* trim: remove trailing blanks, tabs, newlines */
int trim(char s[])
{
  int n;
  for (n = strlen(s)-1; n >= 0; n--)
    if (s[n] != ' ' && s[n] != '\t' && s[n] != '\n')
      break;
  s[n+1] = '\0';
  return n;
}

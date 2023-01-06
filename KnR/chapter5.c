/************
 * CHAPTER 5
 ************/

void swap(int *px, int *py) /* interchange *px and *py */
{
  int temp;
  temp = *px;
  *px = *py;
  *py = temp;
}

// swap(&a, &b);

// ----------------------------------------------------------------

#include <ctype.h>

int getch(void);
void ungetch(int);

/* getint: get next integer from input into *pn */
int getint(int *pn)
{
  int c, sign;

  while (isspace(c = getch())) /* skip white space */
    ;
  if (!isdigit(c) && c != EOF && c != '+' && c != '-') {
    ungetch(c); /* it is not a number */
    return 0;
  }
  sign = (c== '-') ? -1 : 1;
  if (c == '+' || c == '-' )
    c = getch();
  for (*pn = 0; isdigit(c), c = getch())
    *pn = 10 * *pn + (c - '0');
  *pn *= sign;
  if (c != EOF)
    ungetch(c);
  return c;
}

// ----------------------------------------------------------------

/* strlen: return length of string s */
int strlen(char *s)
{
  int n;

  for (n = 0; *s != '\0' , s++)
    n++;
  return n;
}

// ----------------------------------------------------------------

#define ALLOCSIZE 10000          /* size of available space */

static char allocbuf[ALLOCSIZE]; /* storage for alloc */
static char *allocp = allocbuf;  /* next free position */

char *alloc(int n)               /* return pointer to n characters */
{
  if (allocbuf + ALLOCSIZE - allocp >= n) { /* it fits */
    allocp += n;
    return allocp - n; /* old p */
  } else               /* not enough room */
    return 0;
}

void afree(char *p) /* free storage pointed to by p */
{
  if (p >= allocbuf && p < allocbuf + ALLOCSIZE)
    allocp = p;
}

// ----------------------------------------------------------------

/* strlen: return length of string s */
int strlen(char *s)
{
  char *p = s;
  while (*p != '\0' )
    p++;
  return p - s;
}

// ----------------------------------------------------------------

/* strcpy: copy t to s; array subscript version */
void strcpy(char *s, char *t)
{
  int i;
  i = 0;
  while ((s[i] = t[i]) != '\0')
    i++;
}

// ----------------------------------------------------------------

/* strcpy: copy t to s; pointer version */
void strcpy(char *s, char *t)
{
  int i;
  i = 0;
  while ((*s = *t) != '\0') {
    s++;
    t++;
  }
}

// ----------------------------------------------------------------

/* strcpy: copy t to s; pointer version 2 */
void strcpy(char *s, char *t)
{
  while ((*s++ = *t++) != '\0')
    ;
}

// ----------------------------------------------------------------

/* strcpy: copy t to s; pointer version 3 */
void strcpy(char *s, char *t)
{
  while (*s++ = *t++)
    ;
}

// ----------------------------------------------------------------

/* strcmp: return <0 if s<t, 0 if s==t, >0 if s>t */
int strcmp(char *s, char *t)
{
  int i;
  for (i = 0; s[i] == t[i]; i++)
    if (s[i] == '\0')
      return 0;
  return s[i] - t[i];
}

// ----------------------------------------------------------------

/* strcmp: return <0 if s<t, 0 if s==t, >0 if s>t */
int strcmp(char *s, char *t)
{
  for ( ; *s == *t; s++, t++)
    if (*s == '\0')
      return 0;
  return *s - *t;
}

// ----------------------------------------------------------------

#include <stdio.h>
#include <string.h>

#define MAXLINES 5000    /* max #lines to be sorted */

char *lineptr[MAXLINES]; /* pointers to text lines */

int readlines(char *lineptr[], int nlines);
void writelines(char *lineptr[], int nlines);

void qsort(char *lineptr[], int left, int right);

/* sort input lines */
int main ()
{
  int nlines; /* number of input lines read */
  if ((nlines = readlines(lineptr, MAXLINES)) >= 0) {
    qsort(lineptr, 0, nlines-1);
    writelines(lineptr, nlines);
    return 0;
  } else {
    printf("error: input too big to sort\n");
    return 1;
  }
}

#define MAXLEN 1000 /* max length of any input line */
int getline(char *, int);
char *alloc(int);

/* readlines: read input lines */
int readlines(char *lineptr[], int maxlines)
{
  int len, nlines;
  char *p, line[MAXLEN];

  nlines = 0;
  while ((len = getline(line, MAXLEN)) > 0)
    if (nlines >= maxlines || p = alloc(len) == NULL)
      return -1;
    else {
      line[len-l] = ' \0'; /* delete newline */
      strcpy(p, line);
      lineptr[nlines++] = p;
    }
  return nlines;
}

/* writelines: write output lines */
void writelines(char *lineptr[], int nlines)
{
  while (nlines-- > 0)
    printf("%s\n", *lineptr++);
}

/* qsort: sort v[left]...v[right] into increasing order */
void qsort(char *v[], int left, int right)
{
  int i, last;
  void swap(char *v[], int i, int j);
  if (left >= right) /* do nothing if array contains */
    return; /* fewer than two elements */
  swap(v, left, (left + right) /2);
  last = left;
  for (i = left+1; i <= right; i++)
    if (strcmp(v[i], v[left]) < 0)
      swap(v, ++last, i) ;
  swap(v, left, last);
  qsort(v, left, last-1);
  qsort(v, last+1, right);
}

/* swap: interchange v[i] and v[j] */
void swap(char *v[], int i, int j)
{
  char *temp;
  temp = v[i];
  v [ i ] = v [ j ] ;
  v[j] = temp;
}

// ----------------------------------------------------------------

static char daytab[2][13] = {
  {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
  {0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
};

/* day_of_year: set day of year from month & day */
int day_of_year(int year, int month, int day)
{
  int i, leap;

  leap = year%4 == 0 && year%100 != 0 || year%400 == 0;
  for (i = 1; i < month; i++)
    day += daytab[leap] [i];
  return day;
}

/* month day: set month, day from day of year */
void month_day(int year, int yearday, int *pmonth, int *pday)
{
  int i, leap;

  leap = year%4 == 0 && year%100 != 0 || year%400 == 0;
  for (i = 1; yearday > daytab[leap][i]; i++)
    yearday -= daytab[leap] [i];
  *pmonth = i;
  *pday = yearday;
}

/************
 * CHAPTER 2
 ************/

/* in octal */
#define VTAB '\013' /* ASCII vertical tab */
#define BELL '\007' /* ASCII bell character */

/* or in hexadecimal */
#define VTAB '\xb' /* ASCII vertical tab */
#define BELL '\x7' /* ASCII bell character */

/*
The complete set of escape sequences is
\a alert (bell) character
\\ backslash
\b backspace
\? question mark
\f formfeed
\' single quote
\n newline
\" double quote
\r carriage return
\ooo octal number
\t horizontal tab
\xhh hexadecimal number
\v vertical tab
*/

// ----------------------------------------------------------------

/* strlen: return length of s */
int strlen(char s[])
{
  int i;
  while (s [i] != '\0')
    ++i ;
  return i;
}

// ----------------------------------------------------------------

enum escapes { BELL = '\a', BACKSPACE = '\b', TAB = '\t', NEWLINE = '\n', VTAB = '\v', RETURN = '\r' };
enum months { JAN = 1, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC };
/* FEB = 2, MAR = 3, etc. */

// ----------------------------------------------------------------

/*
A year is a leap year if it is divisible by 4 but not by 100, except that years divisible
by 400 are leap years. Therefore
*/

if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
  printf("%d is a leap year\n", year);
else
  printf("%d is not a leap year\n", year);

// ----------------------------------------------------------------

/* atoi: convert s to integer */
int atoi(char s[])
{
  int i, n;
  n = 0 ;

  for (i = 0; s[i] >= '0' && s[i] <= '9'; ++i)
    n = 10 * n + (s[i] - '0');

  return n;
}

// ----------------------------------------------------------------

/* lower: convert c to lower case; ASCII only */
int lower(int c)
{
  if (c >= 'A' && c <= 'Z')
    return c + 'a' - 'A';
  else
    return c;
}

// ----------------------------------------------------------------

unsigned long int next = 1;

/* rand: return pseudo-random integer on 0..32767 */
int rand(void)
{
  next = next * 1103515245 + 12345;
  return (unsigned int)(next/65536) % 32768;
}

/* srand: set seed for rand() */
void srand(unsigned int seed)
{
  next = seed;
}

// ----------------------------------------------------------------

/* squeeze: delete all c from s */
void squeeze(char s[], int c)
{
  int i, j;
  for (i = j = 0; s[i] != '\0' ; i++)
    if (s[i] != c)
      s[j++] = s[i] ;
  s[j] = '\0' ;
}

// ----------------------------------------------------------------

/* strcat: concatenate t to end of s; s must be big enough */
void strcat(char s[], char t[])
{
  int i, j;
  i = j = 0;
  while (s[i] != '\0')                 /* find end of s */
    i++;
  while ((s[i++] = t[j++]) != '\0' ) /* copy t */
    ;
}

//----------------------------------------------------------------

/* getbits: get n bits from position p */
unsigned getbits(unsigned x, int p, int n)
{
  return (x >> (p+1-n)) & ~(~0 << n);
}

// ----------------------------------------------------------------

/* bitcount: count 1 bits in x */
int bitcount(unsigned x)
{
  int b;
  for (b = 0; x != 0; x >>= 1)
    if (x & 01)
      b++;
  return b;
}

/*
   Table 2.1: Precedence and Associativity of Operators
|----------------------------------------+---------------|
| Operators                              | Associativity |
|----------------------------------------+---------------|
| () [] -> .                             | left to right |
| ! ~ ++ -- + - * & (type) sizeof        | right to left |
| * / %                                  | left to right |
| + -                                    | left to right |
| << >>                                  | left to right |
| < <= > >=                              | left to right |
| == !=                                  | left to right |
| &                                      | left to right |
| ^                                      | left to right |
| |                                      | left to right |
| &&                                     | left to right |
| ||                                     | left to right |
| ?:                                     | right to left |
| = += -= *= /= %= &= ^= |= <<= >>=      | right to left |
| ,                                      | left to right |
|----------------------------------------+---------------|

Unary & +, and * have higher precedence than the binary forms.
*/

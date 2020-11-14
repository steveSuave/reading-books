(* lets do dis *)

true;

42;
~84;

"Is this a string?";

(* lists *)
[1,4,9,16,25];
["ant","beetle","caterpillar","dragonfly","earwig"];
[]; nil; (* same value *)
[[1,1],[2,8],[3,27],[4,64],[5,125]];

(* tuples *)
("VDUs", 250, 120);
(("Anna", "Able"), "Accounts", 101);

[(("Anna", "Able"), "Accounts", 101),
 (("Betty","Baker"), "Boiler room", 102),
 (("Chloe", "Charlie"), "Customer orders", 103)];

(* ============================================= *)

(* bool *)
not; (* andalso, orelse *)

(* int, real *)
op div;
op /;

(* string *)
op ^; 
size;

(* various functions *)
hd; tl;
op ::;

ord;
chr;

explode;
implode;

(* 
   infix overloaded comparison operators 

   = <>        are for bools, ints, strings, lists, tuples 
   < <= >= >   are for numbers and strings
*)

(* ============================================= *)

fn x => x + 1;
fn x => fn y => not (x orelse y);
fn (x,y) => not (x orelse y);

fn (x: int) => x * x;
fn (x: int, y: int) => x*x + y*y;

val sq = fn (x: int) => x * x;

val impl = fn (x, y) => if x
                        then y
                        else true;

(* for recursive *)
val rec length =
 fn (l: int list) => if l = []
                     then 0
                     else 1 + length(tl l);

(* alternative clausal form *)
fun length [] = 0 
  | length (_ :: t: int list)  = 1 + length t; 

(* ============================================= *)

fun sinsert (s: string, l: string list) =
    if l = []
    then [s]
    else
        if s < hd l
        then s :: l
        else
            hd l :: sinsert(s, tl l);

sinsert("b", ["a", "c", "d"]);
           
(* ============================================= *)

(* unspecified type *)
fun len2 [] = 0 
  | len2 (h::t) = 1 + len2 t; 

(* it only works with ints *)
fun insert1 i [] = [i] 
  | insert1 i (h::t) =
    if i<h
    then i::h::t
    else h::(insert1 i t);

(* waits for a function ('a 'a -> bool) as a first arg *)
fun insert2 _ i [] = [i] 
  | insert2 comp i (h::t) =
    if comp (i,h)
    then i::h::t
    else h::(insert2 comp i t);

(* comp gets the value of the following passed function *)
val sinsert2 = insert2(fn (s1:string, s2:string) => s1 < s2);
(* integer comparison function for comp *)
val iinsert = insert2(fn (i1: int, i2: int) => i1 < i2);

(* ============================================= *)

type forename = string;
type surname = string;
type person = forename * surname;

type whole_numb = int;
type integer = int;

datatype traffic_light = red | amber | green;
fun change red = green 
  | change green = amber 
  | change amber = red;

datatype 'a ls = lnil | cons of 'a * ('a ls);

fun join lnil = "" |
    join (cons(s:string, l:(string ls))) = s^join l;

join (cons("here", cons("we", cons("go", lnil))));
 
type intlist = int ls;


datatype number = intN of int | realN of real;
intN(3);
realN(3.3);

(* smlnj gives warning on the following two *)
fun ivalue( intN(n: int) ) = n;
fun rvalue( realN(r: real) ) = r;

(* ============================================= *)

datatype inttree = empty0 | node0 of int * inttree * inttree;
empty0;
node0;

fun tadd0(v: int) empty0 = node0(v, empty0, empty0) 
  | tadd0(v: int) (node0(nv: int, l: inttree, r: inttree)) =
    if v < nv
    then node0(nv, tadd0 v l, r)
    else node0(nv, l, tadd0 v r);

val root = empty0;
val root = tadd0 5 root;
val root = tadd0 3 root;
val root = tadd0 7 root;
val root = tadd0 2 root;
val root = tadd0 4 root;
val root = tadd0 9 root;

fun append( x: 'a list, [] ) = x 
  | append( [], x: 'a list ) = x 
  | append( (h: 'a)::(t: 'a list), l: 'a list ) =
    h::append(t, l);

fun traverse0 empty0 = [] 
  | traverse0 (node0(v: int, l: inttree, r: inttree)) =
    append( traverse0 l, (v :: traverse0 r) );

datatype 'a tree = empty | node of 'a * ('a tree) * ('a tree);

(* less is a function waiting to be
  passed in as argument  *)
fun tadd _ (v: 'a) empty =  node(v, empty, empty) 
  | tadd (less: 'a -> ('a -> bool))
         (v: 'a)
         (node(nv: 'a, l: 'a tree, r: 'a tree)) =
    if less v nv
    then node(nv, tadd less v l, r)
    else node(nv, l, tadd less v r);

fun traverse empty = [] 
  | traverse( node(v: 'a, l: 'a tree, r: 'a tree) ) =
    append( traverse l, v::traverse r);

(* ============================================= *)

(* lambda *)

fn x => x;

(fn x => x) (fn x => x);

fn f => fn x => (f x);

(fn f => fn x => (f x)) (fn x => x) (fn x => x);

val identity = fn x => x;
identity identity;

val apply = fn f => fn x => (f x);
apply identity identity;

(* not allowed because s is interpreted as 'a -> 'b
   so it needs 'a as input and not ('a -> 'b) -> 'b *)
fn s => (s s);

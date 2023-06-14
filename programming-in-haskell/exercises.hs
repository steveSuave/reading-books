----------------------------------------------------------------
-- chapter 1 introduction

-- 1. Give another possible calculation for the result of double (double 2).
double x = x + x

-- 3. Define a function product that produces the product of a list of
-- numbers, and show using your definition that product [2,3,4] = 24.
prodd [] = 1
prodd (x:xs) = x * prodd xs

----------------------------------------------------------------
-- chapter 2 first steps

-- 3. The script below contains three syntactic errors. Correct these
-- errors and then check that your script works properly using GHCi.
-- N = a ’div’ length xs
--      where
--          a = 10
--         xs = [1,2,3,4,5]

h = a `div` length xs
  where
    a = 10
    xs = [1,2,3,4,5]

-- 4. The library function last selects the last element of a
-- non-empty list; for example, last [1,2,3,4,5] = 5. Show how the
-- function last could be defined in terms of the other library
-- functions introduced in this chapter. Can you think of another
-- possible definition?

-- llast xs = head (drop (length xs - 1) xs)
-- llast xs = head (reverse xs)
llast xs = xs !! (length xs - 1)


-- 5. The library function init removes the last element from a
-- non-empty list; for example, init [1,2,3,4,5] = [1,2,3,4]. Show how
-- init could similarly be defined in two different ways

-- iinit xs = reverse (tail (reverse xs))
iinit xs = take (length xs - 1) xs

----------------------------------------------------------------
-- chapter 3 types and classes

----------------------------------------------------------------
-- chapter 4 defining functions

-- 3. Consider a function safetail :: [a] -> [a] that behaves in the
-- same way as tail except that it maps the empty list to itself
-- rather than producing an error. Using tail and the function
-- null :: [a] -> Bool that decides if a list is empty or not,
-- define safetail using:
-- a. a conditional expression;
-- b. guarded equations;
-- c. pattern matching.

safetail :: [a] -> [a]
-- safetail xs = if null xs then [] else tail xs
-- safetail xs | null xs   = []
--             | otherwise = tail xs
safetail [] = []
safetail xs = tail xs

-- 7. Show how the meaning of the following curried function
-- definition can be formalised in terms of lambda expressions:
-- mult :: Int -> Int -> Int -> Int
-- mult x y z = x*y*z

-- (\x -> \y -> \z -> x*y*z) 1 2 3

----------------------------------------------------------------
-- chapter 5 list comprehensions

-- 1. Using a list comprehension, give an expression that calculates
-- the sum 12 + 22 + ... 1002 of the first one hundred integer  squares.
-- sum [x^2 | x <- [1..100]]

-- 2. Suppose that a coordinate grid of size m × n is given by the
-- list of all pairs (x, y) of integers such that 0 ≤ x ≤ m and 0 ≤ y ≤ n
-- Using a list comprehension, define a function
-- grid :: Int -> Int -> [(Int,Int)]
-- that returns a coordinate grid of a given size. For example:
-- > grid 1 2
-- [(0,0),(0,1),(0,2),(1,0),(1,1),(1,2)]

grid m n = [(x,y) | x <- [0..m], y <- [0..n]]

-- 4. In a similar way to the function length, show how the library
-- function replicate :: Int -> a -> [a] that produces a list of
-- identical elements can be defined using a list comprehension. For
-- example:
-- > replicate 3 True
-- [True,True,True]

rreplicate n v = [v | _ <- [1..n]]

-- 5. A triple (x, y, z) of positive integers is Pythagorean if it
-- satisfies the equation x2 + y2 = z2. Using a list comprehension
-- with three generators, define a function
-- pyths :: Int -> [(Int,Int,Int)] that returns the list of all such
-- triples whose components are at most a given limit. For example:
-- > pyths 10
-- [(3,4,5),(4,3,5),(6,8,10),(8,6,10)]

pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]

----------------------------------------------------------------
-- chapter 6 recursive functions

-- 2. Define a recursive function sumdown :: Int -> Int that returns
-- the sum of the non-negative integers from a given value down to
-- zero. For example, sumdown 3 should return the result 3+2+1+0 = 6.
sumdown :: Int -> Int
sumdown x | x <= 0 = 0
          | otherwise = x + sumdown (x-1)

-- 3. Define the exponentiation operator ^ for non-negative integers
-- using the same pattern of recursion as the multiplication operator *,
-- and show how the expression 2 ^ 3 is evaluated using your definition.

-- exponentiation, (^) gives error
(&) :: Int -> Int -> Int
m & 0 = 1
m & n = m * m & (n-1)

-- 4. Define a recursive function euclid :: Int -> Int -> Int that
-- implements Euclid’s algorithm for calculating the greatest common
-- divisor of two non-negative integers: if the two numbers are equal,
-- this number is the result; otherwise, the smaller number is
-- subtracted from the larger, and the same process is then
-- repeated. For example:
-- > euclid 6 27
-- 3

euclid :: Int -> Int -> Int
euclid m n | m == n = m
           | m < n = euclid (n-m) m
           | otherwise = euclid (m-n) n

-- 6. Without looking at the definitions from the standard prelude,
-- define the following library functions on lists using recursion.

-- a. Decide if all logical values in a list are True:
-- and :: [Bool] -> Bool

andd :: [Bool] -> Bool
andd [] = True
andd (False:_) = False
andd (True:bools) = andd bools

-- b. Concatenate a list of lists:
-- concat :: [[a]] -> [a]

concatt :: [[a]] -> [a]
concatt [] = []
concatt [xs] = xs
concatt (xs:xss) = xs ++ concatt xss

-- c. Produce a list with n identical elements:
-- replicate :: Int -> a -> [a]

rrreplicate :: Int -> a -> [a]
rrreplicate 0 _ = []
rrreplicate n x = x:rrreplicate (n-1) x

-- d. Select the nth element of a list:
-- (!!) :: [a] -> Int -> a

-- e. Decide if a value is an element of a list:
-- elem :: Eq a => a -> [a] -> Bool

-- Note: most of these functions are defined in the prelude using
-- other library functions rather than using explicit recursion, and
-- are generic functions rather than being specific to the type of
-- lists.



-- 7. Define a recursive function merge :: Ord a => [a] -> [a] -> [a]
-- that merges two sorted lists to give a single sorted list. For
-- example:

-- > merge [2,5,6] [1,3,4]
-- [1,2,3,4,5,6]

-- Note: your definition should not use other functions on sorted
-- lists such as insert or isort, but should be defined using explicit
-- recursion.
merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) | x < y = x:merge xs (y:ys)
                    | otherwise = y:merge (x:xs) ys

-- 8. Using merge, define a function msort :: Ord a => [a] -> [a] that
-- implements merge sort, in which the empty list and singleton lists
-- are already sorted, and any other list is sorted by merging
-- together the two lists that result from sorting the two halves of
-- the list separately.  Hint: first define a function
-- halve :: [a] -> ([a],[a]) that splits a list into two halves whose
-- lengths differ by at most one.

-- halve :: [a] -> ([a],[a])
msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort xs = merge (msort (take half xs)) (msort (drop half xs))
  where half = length xs `div` 2

----------------------------------------------------------------
-- chapter 7 Higher-order functions

-- 1. Show how the list comprehension [f x | x <- xs, p x] can be
-- re-expressed using the higher-order functions map and filter.

mf :: (a -> b) -> (a -> Bool) -> [a] -> [b]
mf f p xs = map f (filter p xs)
-- mf (\x -> x+1) even [1,2,3,4] == [(\y->y+1) x | x <- [1,2,3,4], even x]

-- 3. Redefine the functions map f and filter p using foldr.
mmap :: (a -> b) -> [a] -> [b]
mmap f = foldr ((:) . f) []
-- from book:
-- map f = foldr (\x xs -> f x : xs) []

ffilter :: (a -> Bool) -> [a] -> [a]
ffilter p = foldr (\x xs -> if p x then x:xs else xs) []

-- 5. Without looking at the definitions from the standard prelude, define the higher-order library
-- function curry that converts a function on pairs into a curried function, and, conversely, the
-- function uncurry that converts a curried function with two arguments into a function on pairs.
-- Hint: first write down the types of the two functions.

ccurry :: ((a,b) -> c) -> (a -> b -> c)
ccurry f = \x y -> f (x,y)
uuncurry :: (a -> b -> c) -> ((a,b) -> c)
uuncurry f = \(x,y) -> f x y

----------------------------------------------------------------
-- chapter 8 declaring types and classes

-- 1. In a similar manner to the function add, define a recursive multiplication function
-- mult :: Nat -> Nat -> Nat for the recursive type of natural numbers:
-- Hint: make use of add in your definition.

data Nat = Zero | Succ Nat deriving Show

add :: Nat -> Nat -> Nat
add Zero n     = n
add (Succ m) n = Succ (add m n)

mult :: Nat -> Nat -> Nat
mult Zero _     = Zero
mult (Succ m) n = add n (mult m n)

-- 3. Consider the following type of binary trees:
-- data Tree a = Leaf a | Node (Tree a) (Tree a)

-- Let us say that such a tree is balanced if the number of leaves in
-- the left and right subtree of every node differs by at most one,
-- with leaves themselves being trivially balanced. Define a function
-- balanced :: Tree a -> Bool that decides if a binary tree is
-- balanced or not.
-- Hint: first define a function that returns the number of leaves in a tree.

data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Show

demoTree1 = Node (Node (Leaf 1) (Leaf 2)) (Leaf 3)
demoTree2 = Node
          (Node (Leaf 1) (Leaf 2))
          (Node
           (Leaf 3)
           (Node
            (Leaf 4)
            (Node (Leaf 5) (Leaf 6))))

numOfLeaves :: Tree a -> Int
numOfLeaves (Leaf _) = 1
numOfLeaves (Node a b) = (numOfLeaves a) + (numOfLeaves b)

balanced :: Tree a -> Bool
balanced (Leaf _) = True
balanced (Node l r) = abs(numOfLeaves l - numOfLeaves r) <= 1
                      && balanced l && balanced r

-- 4. Define a function balance :: [a] -> Tree a
-- that converts a non-empty list into a balanced tree.
-- Hint: first define a function that splits a list into two halves whose
-- length differs by at most one.

-- there exists a splitAt builtin with ~ similar signature
splitList :: [a] -> ([a],[a])
splitList [] = ([],[])
splitList xs = (firstHalf,secondHalf)
               where
                 halfLen = (length xs) `div` 2
                 firstHalf = take halfLen xs
                 secondHalf = drop halfLen xs

balance :: [a] -> Tree a
balance [x] = Leaf x
balance xs = Node (balance firstHalf) (balance secondHalf)
             where (firstHalf, secondHalf) = splitList xs

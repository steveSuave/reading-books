; abstraction of list from pair
(define first car)
(define rest cdr)
(define adjoin cons)
(define nil '())

; create a list of sequential numbers
(define (enumerate-interval from to)
	(if (> from to) nil
		(adjoin from
			(enumerate-interval (+1 from)  to))))

; pull out nth element of a list
(define (list-ref lst n)
	(if (= n 0)
		(first lst)
		(list-ref (rest lst)
			(- n 1))))

; get length of list
(define (length lst)
	(if (null? lst) 0
		(+ 1 (length (rest lst)))))

; copy list
(define (copy lst)
	(if (null? lst) nil		;base case
		(adjoin (first lst)		;recursion
			(copy (rest lst)))))

; append list1 to list2 (put in front)
(define (append lst1 list2)
	(cond ((null? lst1) lst2)	;base case
		(else
			(adjoin (first lst1)	;recursion
				(append (rest lst1) lst2)))))

; map procedure to list
(define (map proc lst)
	(if (null? lst) nil
		(adjoin (proc (first lst))
			(map proc(rest lst)))))

; filter list according to predicate
(define (filter pred lst)
	(cond ((null? lst) nil)
		((pred (first lst))
			(adjoin (first lst)
				(filter pred (rest lst))))
		(else (filter pred (rest lst)))))

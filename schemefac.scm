(define (fac x)
	(define (fac-iter product counter target)
		(if (> counter target) product (fac-iter (* product counter)(+ counter 1) target)))
	(fac-iter 1 1 x))

(fac 4)

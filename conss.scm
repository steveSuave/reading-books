;; data as procedure, procedure as data

(define (cons2 a b)
	(lambda (m)
		(cond ((= m 1) a)
			  ((= m 2) b))))

(define (car2 x) (x 1))

(define (cdr2 x) (x 2))

;; ===========
;; pure lambda

(define (cons1 a b)
    (lambda (m) (m a b)))

(define (car1 x)
    (x (lambda (a b) a)))

(define (cdr1 x)
    (x (lambda (a b) b)))

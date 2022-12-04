(define incr (lambda (x) (+ x 1)))

(define zero (lambda (x) (lambda (y) y)))
(define one (lambda (x) (lambda (y) (x y))))
(define two (lambda (x) (lambda (y) (x (x y)))))
(define three (lambda (x) (lambda (y) (x (x (x y))))))

(define succ (lambda (a) (lambda (b) (lambda (c) (b ((a b) c))))))
(define add (lambda (a) (lambda (b) ((b succ) a))))

(define mult (lambda (a) (lambda (b) (lambda (c) (a (b c))))))

((((mult three) three) incr) 0)


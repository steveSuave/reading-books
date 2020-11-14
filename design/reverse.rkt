#lang racket

(define x '(1 2 3 4 5))

(define reversa
  (lambda (ls)
    (if (not (empty? ls))
        (append (reversa (rest ls))
                (list (first ls)))
        empty)))


(define (reverse2 ls)
  (local [(define (rev ls acc)
            (if (empty? ls)
                acc
                (rev (rest ls) (cons (first ls) acc))))]
          (rev ls '())))


(reversa  x)
(reverse2 x)

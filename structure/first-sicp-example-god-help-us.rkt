#lang racket

(define (heron-root x)
  (local [(define (square x) (* x x))
          (define (good-enough? guess x)
            (< (abs (- (square guess) x)) .0001))
          (define (improve-guess guess x)
            (avg guess (/ x guess)))
          (define (avg x y) (/ (+ x y) 2))
          (define (sqr-help x guess)
            (if (good-enough? guess x) guess ;(floor guess)
                (sqr-help x (improve-guess guess x))))]
    (sqr-help x 1)))

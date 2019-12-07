; stream-car
; stream-map
; stream-filter

(define (integers-from n)
    (cons-stream n
                (integers-from (+ 1 n))))

(define integers
    (integers-from 1))

;integers

(define (print-stream s)
    (cond ((empty-stream? s) "done")
        (else
            (display (stream-car s))
            (display "\n")
            (print-stream (stream-cdr s)))))

;(print-stream integers)

(define (sieve s)
    (cons-stream
        (stream-car s)
        (sieve (stream-filter
                    (lambda (x)
                        (not
                            (= 0 (remainder x (head s)))))
                    (stream-cdr s)))))
(define primes
  (sieve (integers-from 2)))

(print-stream primes)


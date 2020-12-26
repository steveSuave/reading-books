;; a.k.a. reduce etc.

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(fold-right / 1 '(1 2 3))
;; (/ 1 (/ 2 (/ 3 1)))
;; Value: 3/2

(fold-left / 1 '(1 2 3))
;; (/ (/ (/ 1 2) 3) 1)
;; Value: 1/6


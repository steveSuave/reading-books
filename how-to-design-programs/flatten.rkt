(define l '(1 2 (3 4 (5 6 7) 8 (9 10)) (11 12) 13))

(define (flat l)
  (cond ((null? l) '())
        ((not (pair? (car l)))
         (cons (car l)
               (flat (cdr l))))
        (else (append
                (flat (car l))
                (flat (cdr l))))))

(flat l)


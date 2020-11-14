(check-expect (quicksrt '()                 )  '()                 )
(check-expect (quicksrt '(1)                )  '(1)                )
(check-expect (quicksrt '(1 2 3 4 5)        )  '(1 2 3 4 5)        )
(check-expect (quicksrt '(1 3 2 3 4 5)      )  '(1 2 3 3 4 5)      )
(check-expect (quicksrt '(2 1 3 2 2 3 4 2 5))  '(1 2 2 2 2 3 3 4 5))
(check-expect (quicksrt '(9 8 7 6 5 4 3 2 1))  '(1 2 3 4 5 6 7 8 9))
 
(define (quicksrt l)
  (if (empty? l)
      '()
      (local [(define frst (car l))]
        (append (quicksrt (filter (λ (a) (< a frst)) l))
                (filter (λ (b) (= b frst)) l)
                (quicksrt (filter (λ (c) (> c frst)) l))))))

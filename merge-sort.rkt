;; Implement merge-sort
;; we'll also need 3 helpers
;; merge, take and drop

;(define (merge-sort ls) ls) ;stub

(check-expect (merge-sort '()                 )  '()                 )
(check-expect (merge-sort '(1)                )  '(1)                )
(check-expect (merge-sort '(1 2 3 4 5)        )  '(1 2 3 4 5)        )
(check-expect (merge-sort '(1 3 2 4 3 5)      )  '(1 2 3 3 4 5)      )
(check-expect (merge-sort '(9 8 7 6 5 4 3 2 1))  '(1 2 3 4 5 6 7 8 9))

;; listofNumber -> listofNumber
;; to sort a given list
(define (merge-sort ls)
  (local [(define half (quotient (length ls) 2))]
    (cond [(empty? ls) empty]
          [(empty? (rest ls)) ls]
          [else (merge (merge-sort (take half ls))
                       (merge-sort (drop half ls)))])))

;; listofNumber listofNumber -> listofNumber
;; to merge two ordered listofNumber in ascending order
(define (merge ls1 ls2)
  (cond [(empty? ls1) ls2]
        [(empty? ls2) ls1]
        [(< (first ls1) (first ls2))
         (cons (first ls1) (merge (rest ls1) ls2))]
        [else
         (cons (first ls2) (merge ls1 (rest ls2)))]))

;; number listofNumber -> listofNumber
;; to take n first elements of a list
(define (take n ls)
  (if (= n 0)
      empty
      (cons (first ls)
            (take (- n 1) (rest ls)))))

;; number listofNumber -> listofNumber
;; to drop n first elements of a list
(define (drop n ls)
  (if (= n 0)
      ls
      (drop (- n 1) (rest ls))))

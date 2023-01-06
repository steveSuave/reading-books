;; Exercise 2.18.
;; Define a procedure reverse that takes a list as argument and returns a list of the same elements in reverse order:
;; (reverse (list 1 4 9 16 25))
;; (25 16 9 4 1)
(define (rev l)
  (if (null? l)
      '()
      (append (rev (cdr l)) (list (car l)))))

;; Exercise 2.27
;; Modify your reverse procedure of exercise 2.18 to produce a deep-reverse procedure that takes a list as argument and returns as its value the list with its elements reversed and with all sublists deep-reversed as well. For example,
;; (define x (list (list 1 2) (list 3 4)))
;; x
;; ((1 2) (3 4))
;; (reverse x)
;; ((3 4) (1 2))
;; (deep-reverse x)
;; ((4 3) (2 1))
(define (deep-reverse l)
  (cond ((null? l) '())
        ((pair? (car l))
         (append (deep-reverse (cdr l))
                 (list (deep-reverse (car l)))))
        (else
         (append (deep-reverse (cdr l))
                 (list (car l))))))

;; Exercise 2.28
;; Write a procedure fringe that takes as argument a tree (represented as a list) and returns a list whose elements are all the leaves of the tree arranged in left-to-right order.
;; For example,
;; (define x (list (list 1 2) (list 3 4)))
;; (fringe x)
;; (1 2 3 4)
;; (fringe (list x x))
;; (1 2 3 4 1 2 3 4)
(define (fringe l)
  (cond ((null? l) '())
        ((pair? (car l))
         (append (fringe (car l))
                 (fringe (cdr l))))
        (else
         (cons (car l)
               (fringe (cdr l))))))

;; Exercise 2.33
;; Fill in the missing expressions to complete the following definitions of some basic list-manipulation operations as accumulations:
(define (map p sequence)
  (accumulate (lambda (x y) <??>) nil sequence))
(define (append seq1 seq2)
  (accumulate cons <??> <??>))
(define (length sequence)
  (accumulate <??> 0 sequence))

(define (map2 p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))
(define (append2 seq1 seq2)
  (accumulate cons seq2 seq1))
(define (length2 sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

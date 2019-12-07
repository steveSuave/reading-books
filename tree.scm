(define my-tree (list 4 (list 5 7) 2))
(define tree2 
    (list 
        1 
        2 
        3 
        (list 
            (list 5 8 6) 
            3 
            6 
            (list 
                (list 2 5 4) 
                4))
        (list 1 9 8 5)))

(define treelen     ;; that's lists len, we want the leaf thing
    (lambda (tree)
        (if (null? tree)
            0
            (+ 1 (treelen (cdr tree))))))

;(treelen my-tree)
;(treelen tree2)

(define treeleaf
    (lambda (tree)
        (cond 
            ((null? tree) 0)
            ((pair? (car tree))
                (+ (treeleaf (car tree))
                   (treeleaf (cdr tree))))
            (else
                (+ 1 (treeleaf (cdr tree)))))))

;(treeleaf my-tree)
;(treeleaf tree2)

(define (maptree t proc)
    (cond 
        ((null? t) '())
        ((pair? (car t))
            (cons (maptree (car t) proc)
                  (maptree (cdr t) proc)))
        (else
            (cons (proc (car t))
                  (maptree (cdr t) proc)))))

(maptree tree2 (lambda (x) (* x x)))


; stub
; (define (fn-for-tree t)
;     (cond
;         ((null? t) '())
;         ((pair? (car t))
;             (... (fn-for-tree (car t))
;                  (fn-for-tree (cdr t))))
;         (else
;             (... (car t)
;                  (fn-for-tree (cdr t))))))

;; generalization from the slides of grimsons lecs
;; and a nice tree reversal

(define (tree-manip leaf-op init merge tree)
    (if (null? tree)
        init
        (if (leaf? tree)
            (leaf-op tree)
            (merge (tree-manip leaf-op init merge (car tree))
                   (tree-manip leaf-op init merge (cdr tree))))))

(define (leaf? x)
    (not (pair? x)))

(tree-manip (lambda (x) (* x x)) '() cons '(1(2 (3 4)5)6))
; (1(4(9 16)25)36)
(tree-manip (lambda (x) 1) 0 + '(1(2(3 4)5)6))
; 6 -> number of leaves
(tree-manip (lambda (x) x) '() (lambda (a b) (append b (list a))) '(1(2(3 4)5)6))
; (6(5(4 3)2)1) -> deep reverse


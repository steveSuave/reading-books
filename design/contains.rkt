;; Problem:
;;
;; Starting with the following data definition for a binary tree (not a binary search tree) 
;; design a tail-recursive function called contains? that consumes a key and a binary tree 
;; and produces true if the tree contains the key.

(define-struct node (k v l r))
;; BT is one of:
;;  - false
;;  - (make-node Integer String BT BT)
;; Interp. A binary tree, each node has a key, value and 2 children
(define BT1 false)
(define BT2 (make-node 1 "a"
                       (make-node 6 "f"
                                  (make-node 4 "d" false
                                             (make-node 2 "b" false false))
                                  false)
                       (make-node 7 "g" false false)))

;; Integer node -> Boolean
;; To check if a binary tree contains a key
;;(define (contains? k BT) #f)
(check-expect (contains? 1 BT1) #f)
(check-expect (contains? 9 BT2) #f)
(check-expect (contains? 4 BT2) #t)
(check-expect (contains? 6 BT2) #t)
(check-expect (contains? 7 BT2) #t)
(check-expect (contains? 3 BT2) #f)
(check-expect (contains? 2 BT2) #t)
#;
(define (contains? k bt)
  (cond [(false? bt) #f]
        [(= k (node-k bt)) #t]
        [else
         (local [(define try (contains? k (node-l bt)))]
           (if try
               try
               (contains? k (node-r bt))))]))

(define (contains? k bt)
  (local [(define (fn-for-bt bt todo)
            (cond [(false? bt) (fn-for-lobt todo)]
                  [(= k (node-k bt)) #t]
                  [else
                   (fn-for-lobt 
					   (append 
						   (list (node-l bt) (node-r bt)) 
						   todo))]))
          (define (fn-for-lobt todo)
            (if (empty? todo)
                #f
                (fn-for-bt (first todo) (rest todo))))]
    (fn-for-bt bt empty)))
	

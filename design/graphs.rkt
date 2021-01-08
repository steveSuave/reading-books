;; Node is Symbol
;; interp. the name of a Node

(define theGraph
  (list (list 'A (list 'B 'E))
        (list 'B (list 'E 'F))
        (list 'C (list 'D))
        (list 'D (list))
        (list 'E (list 'C 'F))
        (list 'F (list 'D 'G))
        (list 'G (list))))

;; Node Graph -> listof Node
;; get children of a node in a graph
(check-expect (neighbors 'A theGraph) (list 'B 'E))
(check-expect (neighbors 'C theGraph) (list 'D))
(check-expect (neighbors 'G theGraph) (list))
;(define (neighbors node graph) '()) stub
(define (neighbors node graph)
  (cond [(empty? graph) '()]
        [(equal? node (caar graph))
         (cadar graph)]
        [else
         (neighbors node (rest graph))]))

;; Node Node Graph -> listof (listof Node) | false
;; to find a path between two nodes in a graph
(check-expect (find-path 'A 'C theGraph) (list 'A 'B 'E 'C))
(check-expect (find-path 'E 'C theGraph) (list 'E 'C))
(check-expect (find-path 'E 'D theGraph) (list 'E 'C 'D))
(check-expect (find-path 'B 'A theGraph) false)

(define (find-path orig dest graph)
  (if (equal? orig dest)
      (list dest)
      (local [(define theNeighbors (neighbors orig graph))
              (define result? (find-lop theNeighbors dest graph))]
        (if (false? result?)
            false
            (cons orig result?)))))

;; listofNode Node Graph -> listof (listof Node) | false
(define (find-lop lop dest graph)
  (cond [(empty? lop) false]
        [else
         (local [(define theFirst (find-path (first lop) dest graph))]
           (if (false? theFirst)
               (find-lop (rest lop) dest graph)
               theFirst))]))

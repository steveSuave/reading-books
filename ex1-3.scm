(define (bigsusq a b c)
  (cond ((and (< c a) (< c b)) (+(* a a) (* b b)))
        ((and (< b a) (< b c)) (+(* a a) (* c c)))
        ((and (< a b) (< a c)) (+(* b b) (* c c)))))

(bigsusq 3 2 6)
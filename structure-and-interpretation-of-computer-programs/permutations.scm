(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))
;; if I just map instead of flatmap then on '(1 2 3) I get:
;; (((1 (2 (3))) (1 (3 (2)))) ((2 (1 (3))) (2 (3 (1)))) ((3 (1 (2))) (3 (2 (1)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (permutations sequence)
  (if (null? sequence)
      (list '())
      (flatmap (lambda (element)
                 (map (lambda (permutation)
                        (cons element permutation))
                      (permutations (remove element sequence))))
               sequence)))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))

(permutations '(1 2 3))

;; ]=> ((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))


;; ================================================================
;; Permutations with repetition

(define (permute-repeat size sequence)
  (if (zero? size)
      '(())
      (flatmap (lambda (permutation)
                 (map (lambda (element)
                        (cons element permutation))
                      sequence))
               (permute-repeat (- size 1) sequence))))

(permute-repeat 2 '(1 2 3))

;; ]=> ((1 1) (2 1) (3 1) (1 2) (2 2) (3 2) (1 3) (2 3) (3 3))


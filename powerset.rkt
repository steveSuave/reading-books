(define (power-set set)
  (if (null? set)
      '(())
      (let ((power-set-of-rest (power-set (cdr set))))
        (append power-set-of-rest
                (map (lambda (subset) (cons (car set) subset))
                     power-set-of-rest)))))

(powerset '(1 2 3 4))
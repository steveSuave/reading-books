;; Exercise 1.11. 
;; A function f is defined by the rule that 
;; f(n) = n if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n> 3. 
;; Write a procedure that computes f by means of a recursive process. 
;; Write a procedure that computes f by means of an iterative process.

(define (f n)
  (if (< n 3)
      n
      (local [(define (iter m a b c)
                (if (= m 0)
                    c
                    (iter (- m 1)
                          (+ a (* 2 b) (* 3 c))
                          a
                          b)))]
        (iter n 2 1 0))))

(define (fn x)
  (if (< x 3)
      x
      (+ (fn (- x 1))
         (* 2 (fn (- x 2)))
         (* 3 (fn (- x 3))))))

(fn 25)
(f 25)

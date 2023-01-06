;; Exercise 4.3.
;; Rewrite eval so that the dispatch is done in data-directed style.
;; (You may use the car of a compound expression as the type of the expression, as is appropriate for the syntax implemented in this section.)

;; ->
;; We will create a list of cons cells mapping from special-form to eval-function
;; This needs a standardized interface for all eval-* functions hence we need to define
;; a few helpers for lambda, begin, cond and quote to accept exp and env as parameters.
(define (m-eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((special-form? exp)
         ((get-handler (operator exp)) exp env))
        ((application? exp)
         (m-apply (m-eval (operator exp) env)
                  (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

(define special-forms
  (list (cons 'quote  eval-quote)
        (cons 'set!   eval-assignment)
        (cons 'define eval-definition)
        (cons 'if     eval-if)
        (cons 'lambda eval-lambda)
        (cons 'begin  eval-begin)
        (cons 'cond   eval-cond)
        (cons 'and    eval-and)
        (cons 'or     eval-or)
        ))

(define (special-form? exp)
  (assq (car exp) special-forms))

(define (get-handler operator)
  (cdr (assoc operator special-forms)))

(define (eval-lambda exp env)
  (make-procedure (lambda-parameters exp) (lambda-body exp) env))

(define (eval-begin exp env)
  (eval-sequence (cdr exp) env))

(define (eval-cond exp env)
  (m-eval (cond->if exp) env))

(define (eval-quote exp env)
  (cadr exp))


;; ----------------------------------------------------------------------------------------------
;; Exercise 4.4.     Recall the definitions of the special forms and and or from chapter 1:

;; * and: The expressions are evaluated from left to right. If any expression evaluates to false,
;;  false is returned; any remaining expressions are not evaluated. If all the expressions
;;  evaluate to true values, the value of the last expression is returned. If there are no
;;  expressions then true is returned.

;; * or: The expressions are evaluated from left to right. If any expression evaluates to a true
;;  value, that value is returned; any remaining expressions are not evaluated. If all expressions
;;  evaluate to false, or if there are no expressions, then false is returned.

;; Install and and or as new special forms for the evaluator by defining appropriate syntax
;; procedures and evaluation procedures eval-and and eval-or. Alternatively, show how to
;; implement and and or as derived expressions.

;; ->
;; Two special-form evaluator functions
;; Note that there is no use of data-abstraction
;; Instead of cdr we ought to use syntax functions
;; e.g. (and-clauses exp) etc.
(define (eval-and exp env)
  (define (helper clauses)
    (if (null? clauses)
        true
        (let ((car-val (m-eval (car clauses) env)))
          (cond ((and (null? (cdr clauses)) (not (false? car-val)))
                 car-val)
                ((false? car-val) false)
                (else (helper (cdr clauses)))))))
  (helper (cdr exp)))

(define (eval-or exp env)
  (define (helper clauses)
    (if (null? clauses)
        false
        (let ((car-val (m-eval (car clauses) env)))
          (if (not (false? car-val))
              car-val
              (helper (cdr clauses))))))
  (helper (cdr exp)))

;; Transform and evaluate 'and and 'or as if expressions
;; Again we would benefit if instead of (cdr exp) we used a syntax function.
(define (eval-and exp env)
  (m-eval (and->if exp) env))

(define (and->if exp)
  (define (helper clauses)
    (cond ((null? clauses) 'true)
          ((null? (cdr clauses)) (car clauses))
          (else
           (make-if (car clauses)
                    (helper (cdr clauses))
                    'false))))
  (helper (cdr exp)))

(define (eval-or exp env)
  (m-eval (or->if exp) env))

(define (or->if exp)
  (define (helper clauses)
    (if (null? clauses)
        'false
        (make-if (car clauses)
                 (car clauses)
                 (helper (cdr clauses)))))
  (helper (cdr exp)))

;; ----------------------------------------------------------------------------------------------
;; Exercise 4.14.  Eva Lu Ator and Louis Reasoner are each experimenting with the metacircular evaluator.
;; Eva types in the definition of map, and runs some test programs that use it. They work fine.
;; Louis, in contrast, has installed the system version of map as a primitive for the metacircular evaluator.
;; When he tries it, things go terribly wrong. Explain why Louis's map fails even though Eva's works.

;; The reason is that the system version of map expects a lambda object with a different representation than
;; the one implemented in the meta-circular evaluator.

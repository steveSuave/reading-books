(define nil '())

(define (make-stack) (cons 'stack nil))

(define (stack? stack)
	(and (pair? stack) (eq? 'stack (car stack))))

(define (empty-stack? stack)
	(if (not (stack? stack))
		(error "object not a stack:" stack)
		(null? (cdr stack))))

(define (insert stack elt)
	(cond ((not (stack? stack))
		(error "object not a stack:" stack))
	(else
		(set-cdr! stack (cons elt (cdr stack)))
	 stack)))

(define (delete stack)
	(if (empty-stack? stack)
		(error "stack underflow - delete")
		(set-cdr! stack (cddr stack)))
	stack)

(define (top stack)
	(if (empty-stack? stack)
		(error "stack underflow - top")
		(cadr stack)))



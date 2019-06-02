(define nil '())

(define (front-ptr q) (cadr q))
(define (rear-ptr q) (cddr q))

(define (set-front-ptr! q item)
	(set-car! (cdr q) item))

(define (set-rear-ptr! q item)
	(set-cdr! (cdr q) item)) 

(define (make-queue)
	(cons 'queue (cons nil nil)))

(define (queue? q)
	(and (pair? q) (eq? 'queue (car q))))

(define (empty-queue? q)
	(if (not (queue? q))
		(error "object not a queue:" q)
		(null? (front-ptr q))))

(define (front-queue q)
	(if (empty-queue? q)
		(error "front of empty queue:" q)
		(car (front-ptr q))))

(define (delete-queue q)
	(cond ((empty-queue? q)
		   (error "delete of empty queue:" q))
		(else
			(set-front-ptr! q
				(cdr (front-ptr q)))
			q)))

(define (insert-queue q elt)
	(let ((new-pair (cons elt nil)))
		(cond ((empty-queue? q)
			(set-front-ptr! q new-pair)
			(set-rear-ptr! q new-pair)
			q)
		(else
			(set-cdr! (rear-ptr q) new-pair)
			(set-rear-ptr! q new-pair)
			q))))


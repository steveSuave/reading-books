(define nil '())

; find the value of a key in an associative list
; returns only the first found instance of the given value
(define (find-assoc key alist)
	(cond
		((null? alist) #f)
		((equal? key (caar alist)) (cadar alist))
		(else (find-assoc key (cdr alist)))))

(define a1 '((x 15) (y 20)))
(find-assoc 'y a1) ;==>20

; add key:value pair to the front of an associative list
(define (add-assoc key val alist)
	(cons (list key val) alist))

(define a2 (add-assoc 'y 10 a1))

; a2 ==> ((y 10) (x 15) (y 20))

(find-assoc 'y a2) ;==>10

; Abstract Data Type of a table, implemented as an Alist
; add abstraction barrier
(define table1-tag 'table1) ;data tag

(define (make-table1) (cons table1-tag nil))

(define (table1-get tbl key)
	(find-assoc key (cdr tbl)))

(define (table1-put! tbl key val)
	(set-cdr! tbl (add-assoc key val (cdr tbl))))

(define tt1 (make-table1))
(table1-put! tt1 'y 20)
(table1-put! tt1 'x 15)
(table1-get tt1 'y)

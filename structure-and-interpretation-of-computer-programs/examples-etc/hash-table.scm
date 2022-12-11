; hash function to compute hash value of point abstract data
; assumes already defined selectors

(define (hash-a-point point N)
	(modulo (+ (x-coor point) (y-coor point))
		N)) ; N=size of structure

; modulo x n = the remainder of x/n
; 0<= (modulo x n) <= n-1 for any x


; Vector: fixed size collection with indexed access

; (make-vector size value) ==> a vector with size locations each initially contains value
; (vector-ref v index) ==>> whatever stored at index of v (error if index >=size of v)
; (vector-set! v index val) stores val at that index of v (error if index >= size of v)

; Table2: Table ADT implemented as hash table
(define t2-tag 'table2)
(define (make-table2 size hashfunc)
	(let ((buckets (make-vector size nil)))
		(list t2-tag size hashfunc buckets)))
(define (size-of tbl) (cadr tbl))
(define (hashfunc-of tbl) (caddr tbl))
(define (buckets-of tbl) (cadddr tbl))

; get in table2
(define (table2-get tbl key)
	(let ((index
			((hashfunc-of tbl) key (size-of tbl))))
	(find-assoc key
		(vector-ref (buckets-of tbl) index))))

; put! in table2
(define (table2-put! tbl key val)
	(let ((index
			((hashfunc-of tbl) key (size-of tbl)))
			(buckets (buckets-of tbl)))
		(vector-set! buckets index
				(add-assoc key val
					(vector-ref buckets index)))))

(define tt2 (make-table2 4 hash-a-point))
(table2-put! tt2 (make-point 5 5) 20)
(table2-put! tt2 (make-point 5 7) 15)
(table2-get tt2 (make-point 5 5))

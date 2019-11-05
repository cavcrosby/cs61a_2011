(define (make-table)
	(let ((local-table (list '*table*)))
		(define (lookup entity keys local-local-table)
			(if (equal? keys '())
				(if (equal? entity '())
					false
					(cdr entity))
				(if (equal? (cdr keys) '())
					(let ((new-entity (assoc (car keys) (cdr local-local-table))))
						(if new-entity ; --> record exists
							(lookup new-entity (cdr keys) local-local-table)
							false))
					(let ((new-entity (assoc (car keys) (cdr local-local-table))))
						(if new-entity ; --> sub-table exists
							(lookup '() (cdr keys) new-entity)
							false)))))
		(define (insert! entity value keys local-local-table)
			(let ((new-entity (assoc (car keys) (cdr local-local-table))))
				(if (equal? (cdr keys) '()) ; if true --> then we have a record, not a subtable at this point
					(if new-entity
						(begin (set-cdr! new-entity value) local-local-table)
						(begin (set-cdr! local-local-table (cons (cons (car keys) value) (cdr local-local-table))) local-local-table))
					(if new-entity ; --> we have a subtable, but does it exist? Getting to this points assumes x number of dimensions of tables
						(set-cdr! local-local-table (cons (insert! '() value (cdr keys) new-entity) (cdr local-local-table)))
						(set-cdr! local-local-table (cons (insert! '() value (cdr keys) (list (car keys))) (cdr local-local-table)))))))
		;;(trace insert!)
		(define (dispatch m)
			(cond ((eq? m 'lookup-proc) (lambda (keys) (lookup '() keys local-table)))
				  ((eq? m 'insert-proc!) (lambda (value keys) (if (equal? keys '()) (error "You need at least 1 key to insert into the table") (insert! '() value keys local-table))))
				  (else (error "Unknown operation: TABLE" m))))
			dispatch))
			
			
(define (insert! key value table) ; user interfaces should have the duty of making sure numerous keys can come in
	((table 'insert-proc!) value (list key)))

(define (lookup key table)
	((table 'lookup-proc) (list key)))
	
; (define (fib n)
	; (cond ((= n 0) 0)
		  ; ((= n 1) 1)
		  ; (else (+ (fib (- n 1)) (fib (- n 2))))))

(define (memoize f)
	(let ((table (make-table)))
		(lambda (x)
			(let ((previously-computed-result
					(lookup x table)))
				(or previously-computed-result
					(let ((result (f x)))
						(insert! x result table)
						result))))))

(define memo-fib
	(memoize
		(lambda (n)
			(cond ((= n 0) 0)
				  ((= n 1) 1)
				  (else (+ (memo-fib (- n 1))
						   (memo-fib (- n 2))))))))
						   
; When using memo-fib, you are putting in the table every computation including n, (n - 1).... (n - n). This removes the redundant computation and calls to memo-fib.
; This is especially true for computations on the right branch of the first branch node (or root node).
; When using memo-fib, the number of times memo-fib is invoked is proportional to the n or Big Theta(n).
						   
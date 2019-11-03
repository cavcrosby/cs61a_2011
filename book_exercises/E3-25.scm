(define (make-table)
	(let ((local-table (list '*table*)))
		(define (format-twice lol)
			(apply append (apply append lol)))
		(define (lookup entity . keys)
			(let ((formated-keys (format-twice keys)))
				(if (equal? formated-keys '())
					(if (equal? entity '())
						false
						(cdr entity)))
					(let ((new-entity (assoc (car formated-keys) (cdr local-table))))
						(if new-entity
							(lookup new-entity (cdr formated-keys))
							false))))
		(define (insert! entity value . keys)
			(let ((formated-keys (format-twice keys)))
				(if (equal? formated-keys '())
					(if (equal? entity '())
						false
						(cdr entity))
					(let ((new-entity (assoc (car formated-keys) (cdr local-table))))
						(if (equal? (cdr formated-keys) '()) ; if true --> then we have a record, not a subtable at this point
							(if new-entity
								(set-cdr! new-entity value)
								(set-cdr! local-table (cons (cons (car formated-keys) value) (cdr local-table))))
							(insert! new-entity value (cdr formated-keys))))))
			'ok)
		(define (dispatch m)
			(cond ((eq? m 'lookup-proc) (lambda (. keys) (lookup '() keys)))
				  ((eq? m 'insert-proc!) (lambda (value . keys) (insert! '() value keys)))
				  (else (error "Unknown operation: TABLE" m))))
			dispatch))
			
			
(define (insert! table value . keys)
	((table 'insert-proc!) value keys))

(define (lookup table . keys)
	((table 'lookup-proc) keys))
	
(define t1 (make-table))
(insert! t1 5 'number1)
(insert! t1 6 'number2)
(insert! t1 7 'number7)
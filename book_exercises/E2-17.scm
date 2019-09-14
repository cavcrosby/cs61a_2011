(define (last-pair list-fp)
	(if (null? (cdr list-fp))
		list-fp
		(last-pair (cdr list-fp))))
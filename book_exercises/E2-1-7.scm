(define (last-pair list_fp)
	(if (empty? (cdr list_fp))
		(car list_fp)
		(last-pair (cdr list_fp))))
(define (list-all-satisfies list_fp pred)
	(if (equal? list_fp (filter pred list_fp)) #t #f))
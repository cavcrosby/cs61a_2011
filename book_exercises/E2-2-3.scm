(define (for-each f list_fp)
	(define (for-each-helper f list_fp action)
		(if (empty? (cdr list_fp))
			((lambda (x) (newline) (display x) (newline)) (car list_fp))
			(for-each-helper f (cdr list_fp) (f (car list_fp))))) 
	(for-each-helper f list_fp '()))

; okay is a special value for shceme denoting a undefined value
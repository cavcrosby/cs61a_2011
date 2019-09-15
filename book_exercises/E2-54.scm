(define (equal? sym1 sym2)
	(cond ((and (null? sym1) (null? sym2)) #t)
		  ((or (and (null? sym1) (not (null? sym2))) (and (null? sym2) (not (null? sym1)))) #f)
		  ((or 
				(and 
					(and (symbol? sym1) (symbol? sym2))
					(eq? sym1 sym2))
				(and
					(and 
						(list? sym1)
						(list? sym2))
				(equal? (car sym1) (car sym2))
				(equal? (cdr sym1) (cdr sym2)))
			)
			#t)
			(else #f)))
			
(define l1 '(this is a list))

(define l2 '(this (is a) list))

(define l3 '(this is a))
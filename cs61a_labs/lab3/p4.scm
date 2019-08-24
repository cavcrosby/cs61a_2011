(define (type-check func type-pred datum)
	(if (type-pred datum) (func datum) #f))

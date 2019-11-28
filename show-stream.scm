(define (ss stream number)
	(if (equal? number 0)
		(list '...)
		(cons (stream-car stream) (ss (stream-cdr stream) (- number 1))))) 
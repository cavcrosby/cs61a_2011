(define (repeat-evens sen)
	(every (lambda (x) (if (even? x) (se x x) x)) sen))
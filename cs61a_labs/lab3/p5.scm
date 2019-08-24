;(define (safe-sqrt x) (type-check (lambda (x) (* x x)) number? x))

(define (make-safe func type-pred) (lambda (x) (if (type-pred x) (func x) #f)))

(define (type-check func type-pred datum)
	(if (type-pred datum) (func datum) #f))
	

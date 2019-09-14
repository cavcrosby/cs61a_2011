(define (inc x) (+ 1 x))

(define (double f)
	(lambda (x) : (f (f x))))
	
; (double (lambda (x) : (double (double x)))) --> (((lambda (x) : (((lambda (x) : (double (double x)))(lambda (x) : (double (double x)))))) inc) 5) --> 21
(define (stream-ref s n)
	(if (= n 0)
		(stream-car s)
		(stream-ref (stream-cdr s) (- n 1))))
		
(define (stream-map proc s)
	(if (stream-null? s)
		the-empty-stream
		(cons-stream (proc (stream-car s))
			(stream-map proc (stream-cdr s)))))

(define (stream-enumerate-interval low high)
	(if (> low high)
		the-empty-stream
		(cons-stream
		 low
		 (stream-enumerate-interval (+ low 1) high))))
		 
(define (display-stream s)
	(stream-for-each display-line s))

(define (display-line x) (display x) (newline))

(define (show x)
	(display-line x)
	x)
	
(define x
	(stream-map show (stream-enumerate-interval 0 10)))

(stream-ref x 5)
(stream-ref x 7)

; 01234567 print out (with a newline between them each)
; this makes sense as what is x is a promise to compute (stream-map show (stream-enumerate-interval 1 10))
; hence, this procedure will print the other numbers going up, 0 will be printed automatically before being binded to x
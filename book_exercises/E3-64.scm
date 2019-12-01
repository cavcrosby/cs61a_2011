(define (average x y)
(/ (+ x y) 2))

(define (sqrt-improve guess x)
	(average guess (/ x guess)))

(define (sqrt-stream x)
	(define guesses
		(cons-stream
			1.0
			(stream-map (lambda (guess) (sqrt-improve guess x))
			guesses)))
	guesses)

(define (stream-limit s1 tolerance)
	(let ((next-num (stream-car (stream-cdr s1))))
		(if (< (abs (-
				next-num
				(stream-car s1)))
				tolerance)
			next-num
			(stream-limit (stream-cdr s1) tolerance))))

(define (sqrt x tolerance)
	(stream-limit (sqrt-stream x) tolerance))
		

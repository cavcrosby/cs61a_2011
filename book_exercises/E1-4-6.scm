(define (iterative-improve f g) ;f is if x is good-enough, g is improving x
	(define (repeated guess)
		(if (f guess)
			guess
			(repeated (g guess))))
	(lambda (guess) : (repeated guess)))
	
(define good-enough? (lambda (x) : (lambda (guess) : (< (abs (- (square guess) x)) 0.0001)))) 

(define improve (lambda (x) : (lambda (guess):	(average guess (/ x guess)))))

(define (average x y)
	(/ (+ x y) 2))
	
(define close-enough? (lambda (g) : (lambda (v1) : v1 (< (abs (- v1 (g v1))) 0.00001))))	
	
(define (square x) (* x x))

; f could be (lambda (x) : (lambda (guess x): (< (abs (- (square guess) x)) 0.0001)))
; f will need to be passed something in beginning so (f 5)
; close-enough will need to know how v2 will be different, so by passing it what g is
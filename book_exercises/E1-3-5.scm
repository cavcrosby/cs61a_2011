(define tolerance 0.00001)
(define (fixed-point f first-guess)
	(define (close-enough? guess next)
		(< (abs (- guess next)) tolerance))
	(define (try guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
				next
				(try next))))
	(try first-guess))
	
	
; (define (gold-r n)
	; (/(+ n (sqrt 5)) 2))
	
(define (gold-r n)
	(+ 1 (/ 1 n)))
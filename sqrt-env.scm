(define (square x) (* x x))

(define (sqrt x)
	(let ((good-enough? (lambda (guess) (< (abs (- (square guess) x)) 0.001))))
		(let ((improve (lambda (guess) (average guess (/ x guess)))))
			(let ((sqrt-iter 
				(lambda (guess) 
						(if (good-enough? guess)
							guess
							(sqrt-iter (improve guess))))))
					(sqrt-iter 1.0)))))
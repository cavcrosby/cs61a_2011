; (define (fast-expt b n a)
	; (cond ((= n 0) 1)
		  ; ((even? n) (square (fast-expt b (/ n 2))))
		  ; (else (* b (fast-expt b (- n 1))))))
		  
; (define (square x) (* x x))

(define (fast-expt b n)
	(define (fast-expt-helper b n a)
		(cond ((= n 0) a)
			  (else (if (even? n) (fast-expt-helper b (- n 2) (* a (square b))) (fast-expt-helper b (- n 1) (* a b))))))
	(fast-expt-helper b n 1))
		  
(define (square x) (* x x))
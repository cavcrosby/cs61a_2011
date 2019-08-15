(define (product term a next b)
	(if (> a b)
		1
		(* (term a) (product term (next a) next b))))
		
(define (factorial n)
	(if (= n 0)
		1
		(* n (factorial (- n 1)))))
		
(define (pi-product a b)
	(define (pi-term x)
		(* (/ (* 2 x) (- (* x 2) 1)) (/ (* 2 x) (+ (* x 2) 1))))
	(define (pi-next x)
		(+ x 1))
	(/ (product pi-term a pi-next b) 2))
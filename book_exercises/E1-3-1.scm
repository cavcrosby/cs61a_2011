(define (product term a next b)
	(if (> a b)
		1
		(* (term a) (product term (next a) next b))))
		
(define (factorial n)
	(if (= n 0)
		1
		(* n (factorial (- n 1)))))
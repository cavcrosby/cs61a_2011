(define (filtered-accumulate combiner predicate null-value term a next b)
	(cond ((> a b) null-value)
		  ((predicate a b) (combiner (term a) (filtered-accumulate combiner predicate null-value term (next a) next b)))
		  (else (filtered-accumulate combiner predicate null-value term (next a) next b))))


(define (prime? x n)
	(define starting_prime 2)
	(define (prime_helper y)
		(cond ((= x y) #t)
			  ((= (modulo x y) 0) #f)
			  (else (prime_helper (+ y 1))))) 
	(cond ((< x starting_prime) #f) ; looking at positive primes
		  (else (prime_helper starting_prime))))	
				  
				  
(define (relative-prime? i n)
	(cond ((<= i 0) #f) ; we are just looking for positive integers GCD(i, n) = 1
		  ((equal? (gcd i n) 1) #t)
		  (else #f)))

(define (square x) (* x x))
(define (inc x) (+ x 1))

; a. (filtered-accumulate + prime? 0 square 2 inc 5) --> 38
; b. (filtered-accumulate * relative-prime? 1 square 2 inc 5) --> 576

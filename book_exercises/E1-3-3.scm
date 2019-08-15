(define (filtered-accumulate combiner predicate null-value term a next b)
	(cond ((> a b) null-value)
		  ((predicate a b) (combiner (term a) (filtered-accumulate combiner predicate null-value term (next a) next b)))
		  (else (filtered-accumulate combiner predicate null-value term (next a) next b))))
		  
(define (prime? x n)
	(define i 2) ; 0 and 1 are not primes, 2 and 3 are
	(define (numbers_btwn_i_x i) (if (>= i x) '() (se i (numbers_btwn_i_x (+ 1 i)))))
	(define (is_it_prime? numbers_btwn_i_x)
		(cond ((or (empty? numbers_btwn_i_x) (= (first numbers_btwn_i_x) x)) #t)
			  ((= (remainder x (first numbers_btwn_i_x)) 0) #f)
			  (else (is_it_prime? (bf numbers_btwn_i_x)))))
			
	(is_it_prime? (numbers_btwn_i_x i)))
	; any number below 2 will return #t, this procedure can be improved
				  
(define (relative-prime? i n)
	(cond ((<= i 0) #f) ; we are just looking for positive integers GCD(i, n) = 1
		  ((equal? (gcd i n) 1) #t)
		  (else #f)))

(define (square x) (* x x))
(define (inc x) (+ x 1))

; a. (filtered-accumulate + prime? 0 square 2 inc 5) --> 38
; b. (filtered-accumulate * relative-prime? 1 square 2 inc 5) --> 576

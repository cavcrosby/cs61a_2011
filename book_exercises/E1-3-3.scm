(define (filtered-accumulate combiner predicate null-value term a next b)
	(cond ((> a b) null-value)
		  ((predicate) (combiner (term a) (accumulate combiner null-value term (next a) next b)))
		  (else ((accumulate combiner null-value term (next a) next b)))))
		  
		  
(define (prime? x)
	(define i 2) ; 0 and 1 are not primes, 2 and 3 are
	(define (generate_data_structure i)(if (>= i x) '() (se i (generate_data_structure (+ 1 i) x))))
	(define (other_primes data_structure)
		(cond ((= (first data_structure) x) #t)
			  ((=(remainder x (first data_structure)) 0) #f)
			  (else (other_primes (bf data_structure)))))
			
	(other_primes (generate_data_structure i)))
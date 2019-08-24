(define (next-perf n)
	(define (factors-of i n)
		(cond ((> i (sqrt n)) '())
			  ((equal? (modulo n i) 0) (se i (factors-of (+ 1 i) n) (/ n i)))
			  (else (factors-of (+ 1 i) n))))
	(define (sum-of-factors factors)
		(if (empty? factors) 0 (+ (first factors) (sum-of-factors (bf factors)))))
	(if (equal? (sum-of-factors (bl (factors-of 1 n))) n) ; bl is so we can cut off the last factor, e.g. 1,2,3,6 --> remove 6
		n 
		(next-perf (+ 1 n))))
		
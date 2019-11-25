(define (num-seq n)
	(cons-stream n 
		(num-seq 
			(if (even? n)
				(/ n 2)
				(+ (* n 3) 1)))))
			
			
(define (seq-length stream)
	(+ 1 
		(if (= (stream-car stream) 1)
			0
			(seq-length (stream-cdr stream)))))
	
(define (generate-seq n how-many)
	(ss (num-seq n) how-many))
	
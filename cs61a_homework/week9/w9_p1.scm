(define (vector-append vec1 vec2)
	(define total-length (+ (vector-length vec1) (vector-length vec2)))
	(define (loop vec newvec vec-count newvec-count)
		(cond ((equal? newvec-count total-length) newvec)
			  ((> vec-count (- (vector-length vec) 1)) (loop vec2 newvec 0 newvec-count))
			  (else (begin 
						(vector-set! newvec newvec-count (vector-ref vec vec-count))
						(loop vec newvec (+ vec-count 1) (+ newvec-count 1))))))
	(loop vec1 (make-vector total-length) 0 0))
		

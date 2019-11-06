(define (vector-filter pred vec)
	(define total-length (+ (vector-length vec)))
	(define (how-many keep-number n)
		(cond ((equal? n total-length) keep-number)
			  ((not (pred (vector-ref vec n))) (how-many keep-number (+ n 1)))
			  (else (how-many (+ keep-number 1) (+ n 1)))))
	(define (loop newvec newvec-count n)
		(cond ((equal? n total-length) newvec)
			  ((not (pred (vector-ref vec n))) (loop newvec newvec-count (+ n 1)))
			  (else 
				(begin
					(vector-set! newvec newvec-count (vector-ref vec n))
					(loop newvec (+ newvec-count 1) (+ n 1))))))
	(loop (make-vector (how-many 0 0)) 0 0))
	
(define v1 (vector 1 2 3 4 5 6 7 8))
(define v2 (vector #f #t #f #t #t))
(define l (lambda (i) (if i #t #f)))

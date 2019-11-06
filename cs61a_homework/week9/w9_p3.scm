(define (bubble-sort! vec)
	(define total-length (vector-length vec))
	(define (loop vec n n2)
		(if (equal? n (- total-length 1))
			vec
			(if (> (vector-ref vec n) (vector-ref vec n2))
				(let ((temp (vector-ref vec n2)))
					(begin
						(vector-set! vec n2 (vector-ref vec n))
						(vector-set! vec n temp))
						(loop vec (+ n 1) (+ n2 1)))
			(loop vec (+ n 1) (+ n2 1)))))	
	(loop vec 0 1)
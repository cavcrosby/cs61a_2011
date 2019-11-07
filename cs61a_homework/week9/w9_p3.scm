;a
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
	(define (loop-man)
		(if (or (equal? total-length 1) (equal? total-length 0)) ; for empty vectors
			vec
			(begin
				(loop vec 0 1)
				(set! total-length (- total-length 1))
				(loop-man))))
	(loop-man)) 
	
;b
;
; loop-man manages the number of times that loop needs to be called.
; (e.g. if total-length is 2, then the number of times loop needs to be called will be 1, this is because with one element left there is no need to bubble sort that one element)
; Every call to loop compares up to (n - 1) element in the vector (if we have a vector of (1 2 3), the first time it will be sorted up to element 3 (or index of 2), the second time up to element 2 (index of 1).
; 

;c 
;runtime of the algorithm is big theta n^2
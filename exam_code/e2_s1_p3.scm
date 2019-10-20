(define make-tree cons)
(define children cdr)

(define (max-fanout tree)
	(define (mfh tree)
		(cons (length (children tree))
			  (flatmap (lambda (x) (mfh x)) (children tree)))) ; flatmap works because list of lists of numbers is returned by map
    (apply max (mfh tree))) ; max cannot be applied to just a list of numbers
	
(define t1 '(1 (2 (3) (4)) (5 (6) (7) (8))))

(define (mxfo tree)
	(accumulate max
	      (length (children tree))
	      (map max-fanout (children tree))))

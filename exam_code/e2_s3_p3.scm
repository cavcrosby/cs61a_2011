(define make-tree cons)
(define children cdr)
(define datum car)
(define t1 '(1 (2 (3) (4)) (5 (6) (7) (8))))


(define (datum-filter pred tree)
	(append (if (pred (datum tree)) ; use append instead of cons
			  (list (datum tree))
			  '()) 
		  (flatmap (lambda (t) (datum-filter pred t)) (children tree))
		  ))
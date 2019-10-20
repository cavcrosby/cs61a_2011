(define make-tree cons)
(define children cdr)
(define datum car)
(define t1 '(1 (2 (3) (4)) (5 (6) (7) (8))))


(define (deep-acc op ini s)
	(if (list? s)
		(accumulate op ini (map (lambda (e) (deep-acc op ini e)) s))
		s))
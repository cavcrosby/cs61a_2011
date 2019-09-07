(define (depth ls)
	(if (atom? ls)
		0
		(max (1+ (depth (car ls))) (depth (cdr ls)))))
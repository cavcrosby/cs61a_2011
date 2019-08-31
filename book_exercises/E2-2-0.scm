(define (same-parity x . z)
	(filter (if (even? x) even? odd?) z))
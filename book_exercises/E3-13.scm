(define (make-cycle x)
	(set-cdr! (last-pair x) x)
	x)
	
(define z (make-cycle (list 'a 'b 'c)))

; doing (last-pair z) will result in a infinite loop because the pointer for the last pair in x now points back to the first element in the list
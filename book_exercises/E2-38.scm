(define (fold-left op initial sequence)
	(define (iter result rest)
		(if (null? rest)
			result
			(iter (op result (car rest))
				(cdr rest))))
	(iter initial sequence))
	
(define (fold-right op ini seq)
	(accumulate op ini seq))

; (fold-right / 1 (list 1 2 3)) --> 1.5
; (fold-left / 1 (list 1 2 3)) --> 1.666666
; (fold-right list nil (list 1 2 3)) --> (1 (2 (3 ())))
; (fold-left list nil (list 1 2 3)) --> (((() 1) 2) 3)

; op should have the property of not caring about the order of the arguments given to it. That the whole should be return as the whole
; as long as the same pieces are given to it.
;
; (e.g. *, se)
;
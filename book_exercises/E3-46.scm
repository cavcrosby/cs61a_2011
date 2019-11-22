(define (test-and-set! cell)
	(without-interrupts
		(lambda ()
			(if (car cell) ; a
				true
				(begin (set-car! cell true) ; b
					false)))))
					
;
; While b is about to set the cell's value to true, a could read the cell value right before b sets it. 
; Thus rises the need for a atomic (that is, a mechanism for reading and setting in a single expression) process.
;
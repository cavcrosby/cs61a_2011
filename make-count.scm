(define make-count
	(let ((glob 0))
		(lambda ()
			(let ((loc 0))
				(lambda ()
					(set! loc (+ loc 1))
					(set! glob (+ glob 1))
					(list loc glob))))))
					
; same as
; (define make-count
	; ((lambda (glob)
		; (lambda ()
			; ((lambda (loc)
				; (lambda ()
					; (set! loc (+ loc 1))
					; (set! glob (+ glob 1))
					; (list loc glob))
			; ) 0))
	; ) 0))
	
;
; (let ((var express)) (body)) == ((lambda (var) (body)) express)
;
;
;
;

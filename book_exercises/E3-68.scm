(define ones (cons-stream 1 ones))

(define integers
	(cons-stream 1 (add-streams ones integers)))

(define (interleave s1 s2)
	(if (stream-null? s1)
		s2
		(cons-stream (stream-car s1)
			(interleave s2 (stream-cdr s1)))))
			
			
; (define (pairs s t)
	; (cons-stream
		; (list (stream-car s) (stream-car t))
		; (interleave
			; (stream-map (lambda (x) (list (stream-car s) x))
			; (stream-cdr t))
		; (pairs (stream-cdr s) (stream-cdr t)))))

(define (pairs s t)
	(interleave
	 (stream-map (lambda (x) (list (stream-car s) x))
		t)
	(pairs (stream-cdr s) (stream-cdr t))))
	
;
; Leads to infinite recursion, because of no cons-stream and that integers is a infinite set
;
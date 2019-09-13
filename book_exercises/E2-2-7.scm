; (define (reverse list-fp)
	; ((reverse-helper list-fp) ()))
	
; (define (reverse-helper list-fp)
	; (cond ((empty? (current-pair-next-points-to list-fp)) (adjoin (car list-fp)))
		  ; (else ((lambda (g) 
					; ((lambda (p) 
						; (lambda (next-next-pair) (g (cons p next-next-pair))))
					; (current-pair-value-points-to list-fp)))
				; (reverse-helper (current-pair-next-points-to list-fp)))
				; )))

; (define current-pair-value-points-to car)
; (define current-pair-next-points-to cdr)

; (define (adjoin first_pair) (lambda (next_pair) (cons first_pair next_pair)))

(define list1 '((1 2) (3 4)))
(define list2 '((1 (2 3)) (5 (6 (7 8)))))

(define (reverse list-fp)
	(if (null? list-fp)
		()
		(append (reverse (cdr list-fp)) (list (car list-fp)))))
		
(define (deep-reverse lol)
	(if (list? lol) 
			(reverse (map (lambda (element) (deep-reverse element)) lol))
			lol))
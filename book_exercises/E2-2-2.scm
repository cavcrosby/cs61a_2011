(define (square x) (* x x))

(define (square-list items)
	(iter items nil))
	
(define (iter things answer)
		(if (null? things)
			answer
		(iter (cdr things) (cons (square (car things)) answer))))

; This does not work, because the answer will be appended (not in terms of scheme) backwards, hence, a backwards list

(define (iter things answer)
		(if (null? things)
			answer
		(iter (cdr things) (cons answer (square (car things))))))
			
; This does not work either, but mainly because an empty list is not appended at the last pair in the list
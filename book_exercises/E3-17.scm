(define (count-pairs x)
	(define tp '())
	(define (cph x)
		(cond ((not (pair? x)) 0)
			  ((memq tp x) 0)
			(else 
				(begin
					(set! tp (cons x tp))
					(+ 
					(cph (car x))
					(cph (cdr x))
					1)))))
	(cph x))
	
	
(define last_pair
	(let ((s-pair (cons 1 nil)))
		(set-cdr! s-pair (cons 2 nil))
		(set-cdr! (cdr s-pair) (cons 3 s-pair))
		s-pair))
		
; can correctly sum up single dimension structures, last_pair still goes into infinite loop
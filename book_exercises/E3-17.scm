(define count-pairs
	(let ((tp '()))
		(lambda (x)
			(cond ((not (pair? x)) 0)
				  ((memq x tp) 0)
				  (else 
					(begin
						(set! tp (cons x tp))
						(+ 
						(count-pairs (car x))
						(count-pairs (cdr x))
						1)))))))
	
	
(define last_pair
	(let ((s-pair (cons 1 nil)))
		(set-cdr! s-pair (cons 2 nil))
		(set-cdr! (cdr s-pair) (cons 3 s-pair))
		s-pair))
		
; fixed, credit goes to fgalassi as this one was making my head spin
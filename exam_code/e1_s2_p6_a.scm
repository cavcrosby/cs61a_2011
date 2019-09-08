(define (colors sockdrawer)
	(define (remdup seq)
		(cond ((null? seq) '())
			  ((memq (car seq) (cdr seq)) (remdup (cdr seq)))
			  (else (cons (car seq) (remdup (cdr seq))))))
	(remdup sockdrawer))
			  
(define (howmany color sockdrawer)
	(length (filter (lambda (sock) (eq? sock color)) sockdrawer)))

(define (odd-sock? sockdrawer)
	(if (memq #t (map (lambda (x) (if (even? (howmany x sockdrawer)) #f #t)) (colors sockdrawer))) #t #f))
	
(define drawer1 '(blue blue blue brown grey grey brown blue))
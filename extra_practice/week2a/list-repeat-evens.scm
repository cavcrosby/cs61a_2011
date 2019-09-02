(define (list-repeat-evens list_fp)
	;(define evens (map (lambda (x) (if (even? x) (list x x) x)) list_fp))
	(define evens-dup (apply append (filter pair? evens)))
	(define not-pair? (lambda (x) (not (pair x))))
	(define odds (filter not-pair? a))
	(define list_fp_unorg (append odds (apply append (filter pair? a))))
	(map (lambda (x) (if (member (- x 1) odds) (list (- x 1) x) (list x))) evens)) 
	

(define (count-pairs x)
	(if (not (pair? x))
		0
		(+ (count-pairs (car x))
		   (count-pairs (cdr x))
		   1)))
		   
; (list 1 2 3) returns 3
; (list (list 1) 2 3) returns 4
; (list (list 1) (list 1) (list 1 2)) returns 7

(define last_pair
	(let ((s-pair (cons 1 nil)))
		(set-cdr! s-pair (cons 2 nil))
		(set-cdr! (cdr s-pair) (cons 3 s-pair))
		s-pair))
		
; (count-pairs last_pair) --> infinite loop or segmentation violation
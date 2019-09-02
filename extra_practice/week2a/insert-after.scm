(define (insert-after item mark ls)
	(insert-after-helper item mark 0 (cdr ls) (list (car ls))))
	
(define (insert-after-helper item mark counter ls new-ls)
		(cond ((empty? ls) (append new-ls (list item))) 
		((= mark 0) (append (list item) (list (car new-ls)) ls))
		((>= counter mark) (apply append (append new-ls (list item (car ls))) (list (cdr ls))))
		(else (insert-after-helper item mark (+ 1 counter) (cdr ls) (append new-ls (list (car ls)))))))
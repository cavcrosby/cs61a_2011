(define (list-repeat-evens list_fp)
	(apply append (map (lambda (x) (if (even? x) (list x x) (list x))) list_fp)))
	

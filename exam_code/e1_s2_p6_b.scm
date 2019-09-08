(define (howmany color sockd)
	(car (filter (lambda (x) (if (eq? (car x) color) (cdr x) '())) sockd)))
	
(define drawer1 '((blue 4) (brown 2) (grey 2)))
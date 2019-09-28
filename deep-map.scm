(define (deep-map fn lol)
	(if (list? lol)
		(map (lambda (element) (deep-map fn element))
			lol)
		(fn lol)))
		
(define (deep-map2 fn xmas)
	(cond ((null? xmas) '())
		  ((pair? xmas)
			(cons (deep-map2 fn (car xmas))
				  (deep-map2 fn (cdr xmas))))
		  (else (fn xmas))))
		  
(define (deep-map3 fn lol)
	(cond ((null? lol) '())
		  ((list? lol) (deep-map3 fn (car lol)))
		  (else (append (list (fn lol)) (deep-map3 fn (cdr lol))))))
		  
(define (self x) x)

(define lol '((a b) (c d)))
		

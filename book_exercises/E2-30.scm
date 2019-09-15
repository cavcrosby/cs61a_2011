(define (square x) (* x x))

(define (square-tree1 lol)
	(if (list? lol)
		(map (lambda (element) (square-tree1 element))
			lol)
		(square lol)))
		
		
(define (square-tree2 lol)
	(if (list? lol)
		((lambda (element) (square-forest element)) lol)
		(square lol)))
		
(define (square-forest lol)
		(if (null? lol)
				'()
				(cons (square-tree2 (car lol))
					  (square-tree2 (cdr lol)))))

(define t1 (list 1 (list 2 (list 3 4) 5) (list 6 7)))
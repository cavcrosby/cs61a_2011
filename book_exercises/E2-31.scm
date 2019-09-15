(define (square x) (* x x))

(define (tree-map fn lol)
	(if (list? lol)
		(map (lambda (element) (tree-map fn element))
			lol)
		(fn lol)))
		
(define (square-tree tree) (tree-map square tree))

(define t1 (list 1 (list 2 (list 3 4) 5) (list 6 7)))
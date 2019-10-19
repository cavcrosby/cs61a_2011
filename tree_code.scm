(define (treemap fn tree)
	(make-tree (fn (datum tree))
		(map (lambda (t) (treemap fn t))
			 (children tree) )))
			 
(define (treemap fn tree)
	(make-tree (fn (datum tree))
		(forest-map fn (children tree))))

(define (forest-map fn forest)
	(if (null? forest)
		’()
		(cons (treemap fn (car forest))
			(forest-map fn (cdr forest)))))
			
(define (deep-map fn lol)
	(if (list? lol)
		(map (lambda (element) (deep-map fn element))
			lol)
		(fn lol))) ; only to use when the tree is just a list of lists
		
(define (depth-first-search tree)
	(print (datum tree))
	(for-each depth-first-search (children tree)))
		
(define (breadth-first-search tree)
	(bfs-iter (list tree)))

(define (bfs-iter queue)
	(if (null? queue)
		’done
		(let ((task (car queue)))
			(print (datum task))
			(bfs-iter (append (cdr queue) (children task))))))
			
(define (pre-order tree)
	(cond ((null? tree) ’())
		  (else (print (entry tree))
				(pre-order (left-branch tree))
				(pre-order (right-branch tree)) )))

(define (in-order tree)
	(cond ((null? tree) ’())
		  (else (in-order (left-branch tree))
				(print (entry tree))
				(in-order (right-branch tree)) )))

(define (post-order tree)
	(cond ((null? tree) ’())
		  (else (post-order (left-branch tree))
				(post-order (right-branch tree))
				(print (entry tree)) )))
(define (make-tree entry left right) (list entry left right))
(define left-branch cadr)
(define right-branch caddr)

(define (ash? bt num)
	(if (null? bt)
		'()
		(cons (< (entry bt) num) (map (lambda (t) (ash? t num)) (list (left-branch bt) (right-branch bt)))))) ; bad code

(define (all-smaller? bt num)
	(if (memq #f (ash? bt num)) #f #t))
	
(define t1 (make-tree 5 
			(make-tree 2 
				(make-tree 1 '() '()) 
				(make-tree 4 '() '())) 
			(make-tree 6 
				(make-tree 3 '() '()) 
				(make-tree 7 '() '()))))
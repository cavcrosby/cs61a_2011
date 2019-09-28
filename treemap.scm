(define t1 '(1 (2 (3) (4)) (5 (6) (7) (8))))

(define (treemap fn tree)
	(make-tree (fn (datum tree))
		(map (lambda (t) (treemap fn t))
			 (children tree) )))
			 
; (define (treemap fn tree)
	; (make-tree (fn (datum tree))
		; (forest-map fn (children tree))))

; (define (forest-map fn forest)
	; (if (null? forest)
		; ’()
		; (cons (treemap fn (car forest))
			; (forest-map fn (cdr forest)))))
	
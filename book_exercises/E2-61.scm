(define (union-set set1 set2)
	(cond ((and (null? set1) (null? set2)) '())
		  ((or (null? set1) (null? set2))
			(if (null? set1)
				set2
				set1))
		  (else
			(let ((x1 (car set1)) (x2 (car set2)))
			 (cond ((= x1 x2) (cons x1 (union-set (cdr set1) (cdr set2))))
				   ((< x1 x2) (cons x1 (union-set (cdr set1) set2)))
				   ((< x2 x1) (cons x2 (union-set set1 (cdr set2)))))))))
				   
(define s1 '(1 2 3))
(define s2 '(2 3 4))
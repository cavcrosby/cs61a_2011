(define (mystery1 L1 L2)
	(cons L1 (append L2 L1)))
	
(define (mystery2 L1 L2)
	(list L1 (list L1 L1)))
	
(define (mystery3 L1 L2)
	(append (cons L2 L2) L1))
	
(define list1 '(1 2 3 4))

(define list2 '(2 2 8 3 (4 5)))
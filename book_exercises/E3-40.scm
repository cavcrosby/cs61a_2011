(define x 10)
(parallel-execute 
	(lambda () (set! x (* x x))) ; a
	(lambda () (set! x (* x x x)))) ; b
	
; 
; 1,000,000 (a then b or b then a), 100 (a then b read and sets, a finally setting), 1000 (b then a read and sets, b finally setting), 10000 (b reads first two x's, then get last x based on a reading and setting)
;

;
; 1,000,000 is the only answer left, as neither a or b can interweave between each other
;
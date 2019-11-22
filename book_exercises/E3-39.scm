(define x 10)
(define s (make-serializer))

(parallel-execute
	(lambda () 
		(set! x ((s (lambda () (* x x)))))) ; a
	(s (lambda () (set! x (+ x 1))))) ; b

;
; 101, 121, 100 are still the only values left --> a can read but then b can interrupt and set, leaving the possibility that a could set last with 100
;
	

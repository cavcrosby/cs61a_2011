(define (enumerate-interval low high)
	(if (> low high)
		'()
		(cons low (enumerate-interval (+ low 1) high)) ) )

(define (stream-enumerate-interval low high)
	(if (> low high)
		the-empty-stream
		(cons-stream low (stream-enumerate-interval (+ low 1) high)) ) )

;;; What’s the difference between the following two expressions?

(delay (enumerate-interval 1 3)) ; a 
(stream-enumerate-interval 1 3) ; b

(define r1 (delay (enumerate-interval 1 3))) 
(define r2 (stream-enumerate-interval 1 3))


;
; a's expression returns a promise that would return a list of (1 2 3)
; b's expression returns a promise whose car is 1, with the promise to compute (stream-enumerate-interval (+ 1 low) high)
;
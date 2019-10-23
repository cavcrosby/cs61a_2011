(define (plus1 var)
	(set! var (+ var 1))
	var)

; (set! 5 (+ 5 1))
;	5)
;
; the actual result will return 5 each time (if 5 is whats passed in), since set! is not a lambda, the var as its first argument will also be replaced by whatever var is passed in as
;
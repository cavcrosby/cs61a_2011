(define (stream-enumerate-interval low high)
	(if (> low high)
		the-empty-stream
		(cons-stream
		 low
		 (stream-enumerate-interval (+ low 1) high))))

(define sum 0)
(define (accum x) (set! sum (+ x sum)) sum)

(define (stream-for-each proc s)
	(if (stream-null? s)
	'done
	(begin (proc (stream-car s))
		(stream-for-each proc (stream-cdr s)))))
		
(define (stream-filter pred stream)
	(cond ((stream-null? stream) the-empty-stream)
		  ((pred (stream-car stream))
			(cons-stream (stream-car stream)
				(stream-filter pred
				(stream-cdr stream))))
		(else (stream-filter pred (stream-cdr stream)))))

(define (display-stream s)
	(stream-for-each display-line s))

(define (display-line x) (display x) (newline))

(define seq
	(stream-map accum
	(stream-enumerate-interval 1 20)))
(define y (stream-filter even? seq))
(define z
	(stream-filter (lambda (x) (= (remainder x 5) 0))
	seq))

(stream-ref y 7)
(display-stream z)

;; my guess is the sum is 210 by the time it reaches the last expression
;; (stream-ref y 7) will print 16 10 15 21 28 7
;; (display-stream z) will print 5 15 6 21 7 28 8 36 9 45 10 55 11 66 12 78 13 91 14 105 15 120 16 136 17 153 18 171 19 190 20 210
;; given we are using assignment in addition to streams, these responses will differ if memo-proc is removed (the sum would then be around 235)

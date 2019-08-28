(define (make-point x y) (cons x y))

(define (x-point point) (car point))

(define (y-point point) (cdr point))

(define (make-segment start-point end-point) (cons start-point end-point))

(define (start-segment segment) (car segment))

(define (end-segment segment) (cdr segment))

(define (midpoint-segment segment) (cons (/ (+ (x-point (start-segment segment)) (x-point (end-segment segment))) 2)
										 (/ (+ (y-point (start-segment segment)) (y-point (end-segment segment))) 2)))

(define (print-point p)
	(newline)
	(display "(")
	(display (x-point p))
	(display ",")
	(display (y-point p))
	(display ")"))
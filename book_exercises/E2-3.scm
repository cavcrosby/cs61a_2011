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
	
	


; testing code
(define seg1 (make-segment (make-point 2 5) (make-point 8 5)))
(define seg2 (make-segment (make-point 2 3) (make-point 8 3)))

(define seg3 (make-segment (make-point 3 (- 5)) (make-point 3 4)))
(define seg4 (make-segment (make-point 5 (- 5)) (make-point 5 4)))

(define hr (make-rectangle seg1 seg2))
(define vr (make-rectangle seg3 seg4))

(define (make-rectangle first-segment second-segment)
	(define (hor-parallel? first-segment second-segment)
		(if 
			(and 
				(and (equal? (y-point (start-segment first-segment)) 
						 (y-point (end-segment first-segment)))
					 (equal? (y-point (start-segment second-segment)) 
						 (y-point (end-segment second-segment))))
			    (and (equal? (x-point (start-segment first-segment))
						 (x-point (start-segment second-segment)))
					 (equal? (x-point (end-segment first-segment))
						 (x-point (end-segment second-segment)))))
			#t
			#f))
	(define (ver-parallel? first-segment second-segment)
		(if 
			(and 
				(and  (equal? (x-point (start-segment first-segment)) 
						 (x-point (end-segment first-segment)))
					  (equal? (x-point (start-segment second-segment)) 
						 (x-point (end-segment second-segment))))
				 (and (equal? (y-point (start-segment first-segment))
						 (y-point (start-segment second-segment)))
					  (equal? (y-point (end-segment first-segment))
						 (y-point (end-segment second-segment)))))
			#t
			#f))
	(let ((is-hor-parallel (hor-parallel? first-segment second-segment)) (is-ver-parallel (ver-parallel? first-segment second-segment)))
		(cond ((not (or is-hor-parallel is-ver-parallel)) (error "Need parallel segments (starting/ending points must align either by either x or y)..."))
			  (is-hor-parallel (if (> (y-point (start-segment first-segment)) (y-point (start-segment second-segment))) 
									 (list (start-segment second-segment) (start-segment first-segment) (end-segment second-segment) (end-segment first-segment))
									 (list (start-segment first-segment) (start-segment second-segment) (end-segment first-segment) (end-segment second-segment))))
			  (else (if (> (x-point (start-segment first-segment)) (x-point (start-segment second-segment))) 
									 (list (start-segment second-segment) (start-segment first-segment) (end-segment second-segment) (end-segment first-segment)) 
									 (list (start-segment first-segment) (start-segment second-segment) (end-segment first-segment) (end-segment second-segment)))))))
									 
									 
(define (calculation name)
	(lambda (rectangle) (name rectangle)))
	
(define (width rectangle cord-point)
	(abs (- (cord-point (get-coordinate rectangle)) (cord-point (get-coordinate (other-coordinates rectangle))))))
	
(define (length rectangle cord-point)
	(abs (- (cord-point (get-coordinate rectangle)) (cord-point (get-coordinate (other-coordinates (other-coordinates rectangle)))))))
	
(define (perimeter rectangle)
	(if (equal? (y-point (get-coordinate rectangle)) (y-point (get-coordinate (other-coordinates rectangle)))) ; if we have vertical parallel rectangle
		(* (+ (width rectangle x-point)(length rectangle y-point)) 2)
		(* (+ (width rectangle y-point)(length rectangle x-point)) 2)))
		
(define (area rectangle)
	(if (equal? (y-point (get-coordinate rectangle)) (y-point (get-coordinate (other-coordinates rectangle)))) ; if we have vertical parallel rectangle ; redundant checking if parallel rectangle or not
		(* (width rectangle x-point) (length rectangle y-point))
		(* (width rectangle y-point) (length rectangle x-point))))

(define get-coordinate first)
(define other-coordinates butfirst)
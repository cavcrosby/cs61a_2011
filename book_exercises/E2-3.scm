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

(define (make-rectangle first-segment second-segment)
	(define (segment-straight? cord segment)
		(equal? (cord (start-segment segment)) 
				(cord (end-segment segment))))
	(define (segments-parallel? cord)
		(and  (equal? (cord (start-segment first-segment)) 
						(cord (start-segment second-segment)))
			  (equal? (cord (end-segment first-segment)) 
						(cord (end-segment second-segment)))))
	(define (hor-parallel? first-segment second-segment)
		(if 
			(and 
				(and (segment-straight? y-point first-segment) (segment-straight? y-point second-segment))
			    (and (segments-parallel? x-point)))
			#t
			#f))
	(define (ver-parallel? first-segment second-segment)
		(if 
			(and 
				(and (segment-straight? x-point first-segment) (segment-straight? x-point second-segment))
			    (and (segments-parallel? y-point)))
			#t
			#f))
	(let ((is-hor-parallel (hor-parallel? first-segment second-segment)) (is-ver-parallel (ver-parallel? first-segment second-segment)))
		(cond ((not (or is-hor-parallel is-ver-parallel)) 
						(error "Need parallel segments (starting/ending points must align either by either x or y)..."))
			  (is-hor-parallel 
					(if (> (y-point (start-segment first-segment)) (y-point (start-segment second-segment))) 
						(list (start-segment second-segment) (start-segment first-segment) (end-segment second-segment) (end-segment first-segment))
						(list (start-segment first-segment) (start-segment second-segment) (end-segment first-segment) (end-segment second-segment))))
			  (else 
					(if (> (x-point (start-segment first-segment)) (x-point (start-segment second-segment))) 
						(list (start-segment second-segment) (start-segment first-segment) (end-segment second-segment) (end-segment first-segment)) 
						(list (start-segment first-segment) (start-segment second-segment) (end-segment first-segment) (end-segment second-segment)))))))
									 
									 
(define (width rectangle across-cord)
	(abs (- (across-cord (get-coordinate rectangle)) (across-cord (get-coordinate (other-coordinates rectangle))))))
	
(define (length rectangle across-cord)
	(abs (- (across-cord (get-coordinate rectangle)) (across-cord (get-next-coordinate (other-coordinates rectangle))))))
	
(define (perimeter rectangle)
	(if (equal? (y-point (get-coordinate rectangle)) (y-point (get-coordinate (other-coordinates rectangle)))) ; if we have vertical parallel rectangle
		(* (+ (width rectangle x-point)(length rectangle y-point)) 2)
		(* (+ (width rectangle y-point)(length rectangle x-point)) 2)))
		
(define (area rectangle)
	(if (equal? (y-point (get-coordinate rectangle)) (y-point (get-coordinate (other-coordinates rectangle)))) ; if we have vertical parallel rectangle ; redundant checking if parallel rectangle or not
		(* (width rectangle x-point) (length rectangle y-point))
		(* (width rectangle y-point) (length rectangle x-point))))

(define get-coordinate first)
(define get-next-coordinate (lambda (x) (get-coordinate (other-coordinates x))))
(define other-coordinates butfirst)

; testing code
(define hr (make-rectangle seg1 seg2))
(define vr (make-rectangle seg3 seg4))

(define seg1 (make-segment (make-point 2 5) (make-point 8 5)))
(define seg2 (make-segment (make-point 2 3) (make-point 8 3)))

(define seg3 (make-segment (make-point 3 (- 5)) (make-point 3 4)))
(define seg4 (make-segment (make-point 5 (- 5)) (make-point 5 4)))
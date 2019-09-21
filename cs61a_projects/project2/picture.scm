(define (draw-line v1 v2)
  (penup)
  (setxy (- (* (xcor-vect v1) 200) 100)
	 (- (* (ycor-vect v1) 200) 100))
  (pendown)
  (setxy (- (* (xcor-vect v2) 200) 100)
	 (- (* (ycor-vect v2) 200) 100)))
	 
(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define (right-split painter n)
	(if (= n 0)
		painter
		(let ((smaller (right-split painter (- n 1))))
			(beside painter (below smaller smaller)))))
			
(define (square-limit painter n)
	(let ((quarter (corner-split painter n)))
		(let ((half (beside (flip-horiz quarter) quarter)))
			(below (flip-vert half) half))))
			
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
	  (bottom (beside (bl painter) (br painter))))
      (below bottom top))))
			
(define (corner-split painter n)
	(if (= n 0)
		painter
		(let ((up (up-split painter (- n 1)))
			 (right (right-split painter (- n 1))))
			(let ((top-left (beside up up))
				 (bottom-right (below right right))
				 (corner (corner-split painter (- n 1))))
				(beside (below painter top-left)
						(below bottom-right corner))))))

; E2.44		
(define (up-split painter n)
	(if (= n 0)
		painter
		(let ((smaller (up-split painter (- n 1))))
			(below painter (beside smaller smaller)))))
			
(define (square-of-four tl tr bl br)
	(lambda (painter)
		(let ((top (beside (tl painter) (tr painter)))
			(bottom (beside (bl painter) (br painter))))
		  (below bottom top))))

; E2.45
(define (split orient1 orient2)
	(lambda (painter n) 
		(if (= n 0)
			painter
			(let ((smaller (right-split painter (- n 1))))
				(orient1 painter (orient2 smaller smaller))))))
				
; E2.46
(define make-vect cons)

(define xcor-vect car)

(define ycor-vect cdr)

(define (add-vect vec1 vec2)
	(make-vect (+ (xcor-vect vec1) (xcor-vect vec2)) (+ (ycor-vect vec1) (ycor-vect vec2))))
	
(define (sub-vect vec1 vec2)
	(make-vect (- (xcor-vect vec1) (xcor-vect vec2)) (- (ycor-vect vec1) (ycor-vect vec2))))

(define (scale-vect scale vec)
	(make-vect (* scale (xcor-vect vec)) (* scale (ycor-vect vec))))
	
; E2.47
(define (frame-coord-map frame)
	(lambda (v)
		(add-vect
		 (origin-frame frame)
		 (add-vect (scale-vect (xcor-vect v)
					 (edge1-frame frame))
				   (scale-vect (ycor-vect v)
					 (edge2-frame frame))))))

(define (make-frame origin edge1 edge2)
	(list origin edge1 edge2))
	
(define origin-frame car)

(define edge1-frame cadr)

(define edge2-frame caddr)

; E2.48
(define (segments->painter segment-list)
	(lambda (frame)
		(for-each ; think of for-each in this case as a higher order function
			(lambda (segment)
			 (draw-line
			  ((frame-coord-map frame) (start-segment segment))
			  ((frame-coord-map frame) (end-segment segment))))
			segment-list)))

(define make-segment cons) ; segments can be seen as a pair of vectors

(define start-segment car)

(define end-segment cdr)

; E2.49 a, b, c , and d

;a
							 
(define outline
	(segments->painter (list (make-segment (make-vect 0.0 0.0) (make-vect 0.0 1.0))
							 (make-segment (make-vect 0.0 0.0) (make-vect 1.0 0.0))
							 (make-segment (make-vect 0.0 1.0) (make-vect 1.0 1.0))
							 (make-segment (make-vect 1.0 0.0) (make-vect 1.0 1.0))
								)))

;b						 
(define X
	(segments->painter (list (make-segment (make-vect 0.0 1.0) (make-vect 1.0 0.0))
							 (make-segment (make-vect 0.0 0.0) (make-vect 1.0 1.0))
								)))

;c						 
(define diamond
	(segments->painter (list (make-segment (make-vect 0.0 0.5) (make-vect 0.5 1.0))
							 (make-segment (make-vect 0.5 1.0) (make-vect 1.0 0.5))
							 (make-segment (make-vect 1.0 0.5) (make-vect 0.5 0.0))
							 (make-segment (make-vect 0.5 0.0) (make-vect 0.0 0.5))
								)))

;d							
(define wave
	(segments->painter (list (make-segment (make-vect 0.0 0.8) (make-vect 0.075 .75)) ; start of top portion
								 (make-segment (make-vect 0.075 0.75) (make-vect 0.125 0.7))
								 (make-segment (make-vect 0.125 0.7) (make-vect 0.175 0.7))
								 (make-segment (make-vect 0.175 0.7) (make-vect 0.225 0.725))
								 (make-segment (make-vect 0.225 0.725) (make-vect 0.3 0.735))
								 (make-segment (make-vect 0.3 0.735) (make-vect 0.25 0.78))
								 (make-segment (make-vect 0.25 0.78) (make-vect 0.4 1.0)) ; end of head, do not contact top segments
								 (make-segment (make-vect 0.525 1.0) (make-vect 0.575 0.8)) 
								 (make-segment (make-vect 0.575 0.8) (make-vect 0.55 0.735))
								 (make-segment (make-vect 0.55 0.735) (make-vect 0.6 0.735))
								 (make-segment (make-vect 0.6 0.735) (make-vect 1 0.4)) ; end of top portion
								 (make-segment (make-vect 0.0 0.725) (make-vect 0.125 0.45)) ; start of bottom portion
								 (make-segment (make-vect 0.125 0.45) (make-vect 0.225 0.625))
								 (make-segment (make-vect 0.225 0.625) (make-vect 0.295 0.525))
								 (make-segment (make-vect 0.295 0.525) (make-vect 0.175 0.0)) ; start of feet
								 (make-segment (make-vect 0.4 0.0) (make-vect 0.5 0.175))
								 (make-segment (make-vect 0.5 0.175) (make-vect 0.6 0.0))
								 (make-segment (make-vect 0.8 0.0) (make-vect 0.65 0.475)) ; end of feet
								 (make-segment (make-vect 0.65 0.475) (make-vect 1.0 0.115))
								)))

(define (transform-painter painter origin corner1 corner2)
	(lambda (frame)
		(let ((m (frame-coord-map frame)))
			(let ((new-origin (m origin)))
				(painter (make-frame new-origin 
						 (sub-vect (m corner1) new-origin)
						 (sub-vect (m corner2) new-origin)))))))
						 
(define (flip-vert painter)
	(transform-painter painter
			(make-vect 0.0 1.0) ; new origin
			(make-vect 1.0 1.0) ; new end of edge1
			(make-vect 0.0 0.0))) ; new end of edge2
			
(define (beside painter1 painter2)
	(let ((split-point (make-vect 0.5 0.0)))
	(let ((paint-left
			(transform-painter painter1
				(make-vect 0.0 0.0)
				split-point
				(make-vect 0.0 1.0)))
		  (paint-right
			(transform-painter painter2
				split-point
				(make-vect 1.0 0.0)
				(make-vect 0.5 1.0))))
		(lambda (frame)
		  (paint-left frame)
		  (paint-right frame)))))
		  
; E2.50
(define (flip-horiz painter)
	(transform-painter painter
			(make-vect 1.0 0.0) ; new origin
			(make-vect 0.0 0.0) ; new end of edge1
			(make-vect 1.0 1.0))) ; new end of edge2
			
; E2.51	
(define (below painter1 painter2)
	(let ((split-point (make-vect 0.0 0.5)))
	(let ((paint-below
			(transform-painter painter1
				(make-vect 0.0 0.0)
				(make-vect 1.0 0.0)
				split-point))
		  (paint-above
			(transform-painter painter2
				split-point
				(make-vect 1.0 0.5)
				(make-vect 0.0 1.0))))
		(lambda (frame)
		  (paint-below frame)
		  (paint-above frame)))))
		  
(define full-frame (make-frame (make-vect -0.5 -0.5)
			       (make-vect 2 0)
			       (make-vect 0 2)))
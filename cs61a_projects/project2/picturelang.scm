(define (right-split painter n)
	(if (= n 0)
		painter
		(let ((smaller (right-split painter (- n 1))))
			(beside painter (below smaller smaller)))))
			
(define (square-limit painter n)
	(let ((quarter (corner-split painter n)))
		(let ((half (beside (flip-horiz quarter) quarter)))
			(below (flip-vert half) half))))
			
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

(define (intersection edge1 edge2) (cons (ycor-vect edge1) (xcor-vect edge2)))

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

(define end-segment)

; E2.49 a, b, c , and d

;a
(define (outline frame)
	(segments->painter (list (make-segment (origin-frame frame) (edge1-frame frame)) 
							 (make-segment (origin-frame frame) (edge2-frame frame))
							 (make-segment (edge1-frame frame) (intersection edge1 edge2))
							 (make-segment (intersection (edge1-frame frame) (edge2-frame frame)) (edge2-frame frame)))))

;b						 
(define (X frame)
	(segments->painter (list (make-segment (origin-frame frame) (intersection (edge1-frame frame) (edge2-frame frame)))
							 (make-segment (edge1-frame frame) (edge2-frame frame)))))

;c						 
(define (diamond frame)
	(segments->painter (let ((origin-edge1-vec (make-vect (xcor-vect (origin-frame frame)) (/ (+ (ycor-vect (origin-frame frame)) (ycor-vect (edge1-frame frame))) 2))) ; x cord is of origin (or could have been edge1)
						    (edge1-intersection-vec (make-vect (/ (+ (xcor-vect (edge1-frame frame)) (xcor-vect (intersection (edge1-frame frame) (edge2-frame frame)))) 2) (ycor-vect (intersection (edge1-frame frame) (edge2-frame frame))))) ; y cord is of intersection (or could have been edge1)
							(intersection-edge2-vec (make-vect (xcor-vect (edge2 frame)) (/ (+ (ycor-vect (intersection (edge1-frame frame) (edge2-frame frame))) (ycor-vect (edge2-frame frame))) 2))) ; x cord is of edge2 (or could have been intersection)
							(edge2-origin-vec (make-vect (/ (+ (xcor-vect (edge2-frame frame)) (xcor-vect (origin-frame frame))) 2) (ycor-vect (origin-frame frame))))) ; y cord is of origin (or could have been edge2)
							(list
								(make-segment origin-edge1-vec edge1-intersection-vec)
								(make-segment edge1-intersection-vec intersection-edge2-vec)
								(make-segment intersection-edge2-vec edge2-origin-vec)
								(make-segment edge2-origin-vec origin-edge1-vec)))))

;d							
(define (wave frame))


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
			(make-vect 0.0 0.0) ; new origin
			(make-vect 0.0 1.0) ; new end of edge1
			(make-vect 0.0 (- 1.0)))) ; new end of edge2
			
; E2.51	
(define (below painter1 painter2)
	(let ((paint-below
			(transform-painter painter1
				(make-vect 0.0 0.5)
				(make-vect 0.0 1.0)
				(make-vect 1.0 0.5)))
		  (paint-above
			(transform-painter painter2
				(make-vect 0.0 0.0)
				(make-vect 0.0 0.5)
				(make-vect 1.0 0.0))))
		(lambda (frame)
		  (paint-below frame)
		  (paint-above frame))))
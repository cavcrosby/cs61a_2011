(define (abs x)
  (cond ((< x 0) (* x -1))
	((> x 0) x)
	(else 0)))

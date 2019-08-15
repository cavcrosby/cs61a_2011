(define (squares x)
  (cond ((empty? x) '())
	(else (se (* (first x) (first x)) (squares (bf x))))))

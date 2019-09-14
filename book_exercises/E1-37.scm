;recursive process, k needs to be at least 10 to have the accuracy of 4 decimal places

(define (cont-frac n d k)
	(if (= k 0) (/ n d) (/ n (+ d (cont-frac n d (- k 1))))))
	
;iterative process, k needs to be at least 10 to have the accuracy of 4 decimal places

(define (cont-frac-iter n d k)
	(define (cont-frac-iter-helper n d k t)
		(if (= k 0) (/ 1 t) (cont-frac-iter-helper n d (- k 1) (+ d (/ n t)))
		))
	(cont-frac-iter-helper n d k (/ n d)))

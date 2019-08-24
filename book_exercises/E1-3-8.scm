(define (euler n k)
	(define (cal_d k) (if (equal? (modulo k 3) 1) (* (+ (round (/ k 3)) 1) 2) 1))
	(define (euler-helper n k t)
		(if (= k 0) (/ 1 t) (let ((d (cal_d (- k 1)))) (euler-helper n (- k 1) (+ d (/ n t))))))
	(let ((d (cal_d (- k 1)))) (euler-helper n (- k 1) (/ n d))))

;(if (equal? (modulo (- k 1) 3) 1)

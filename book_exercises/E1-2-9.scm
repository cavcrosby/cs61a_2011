(define (simps_rule f a b n)
	(define delta_x (/ (- b a) n))
	; take (* (/ (/ (- b a) n) 3) out so it is only computed once, while it is multipled by numberous numbers added
	(compute f a b n delta_x)
)

(define (compute f a b n delta_x)
			(* (/ (/ (- b a) n) 3)
			(if (equal? delta_x b)
				1
				(cond ((= delta_x b) (+ (f delta_x) (compute f a b n (+ delta_x (/ (- b a) n)))))
					  ((= delta_x a) (+ (f delta_x) (compute f a b n (+ delta_x (/ (- b a) n)))))
					  (else (if (/ (/ (/ (- b a) n) delta_x) 1)
								(+ (* (f delta_x) 2) (compute f a b n (+ delta_x (/ (- b a) n))))
								(+ (* (f delta_x) 4) (compute f a b n (+ delta_x (/ (- b a) n))))))))))
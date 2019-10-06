; a
; When apply-generic is called with two scheme-number argments, it will result in infinite recursion because apply-generic will contiously be called on transforming the/a scheme-number into a scheme-number.
; However, when apply-generic is called on two complex numbers, it will error out saying that no method exists for those two types (the one that is nested deepest)

; b
; Apply-generic works as is

; c

(define (apply-generic op . args)
	(let ((type-tags (map type-tag args)))
		(let ((proc (get op type-tags)))
			(if proc
				(apply proc (map contents args))
				(if (= (length args) 2)
					(let ((type1 (car type-tags))
						 (type2 (cadr type-tags))
						 (a1 (car args))
						 (a2 (cadr args)))
							(if (not (equal? type1 type2))
								(let ((t1->t2 (get-coercion type1 type2))
									 (t2->t1 (get-coercion type2 type1)))
										(cond (t1->t2
											   (apply-generic op (t1->t2 a1) a2))
											  (t2->t1
											   (apply-generic op a1 (t2->t1 a2)))
											  (else
											   (error "No method for these types"
												(list op type-tags)))))
							(error "No method for these types"
												(list op type-tags)))	
					(error "No method for these types"
						(list op type-tags))))))))
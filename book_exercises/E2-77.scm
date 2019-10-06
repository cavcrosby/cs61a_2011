(define (apply-generic op . args)
	(let ((type-tags (map type-tag args)))
	 (let ((proc (get op type-tags)))
	  (if proc
		 (apply proc (map contents args))
		 (error
			"No method for these types -- APPLY-GENERIC"
			(list op type-tags))))))

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(define (install-rectangular-package)
;; internal procedures
	(define (real-part z) (car z))
	(define (imag-part z) (cdr z))
	(define (make-from-real-imag x y) (cons x y))
	(define (magnitude z)
		(sqrt (+ (square (real-part z)) (square (imag-part z)))))
	(define (angle z) (atan (imag-part z) (real-part z)))
	(define (make-from-mag-ang r a)
		(cons (* r (cos a)) (* r (sin a))))
	;; interface to the rest of the system
	(define (tag x) (attach-tag 'rectangular x))
	(put 'real-part '(rectangular) real-part)
	(put 'imag-part '(rectangular) imag-part)
	(put 'magnitude '(rectangular) magnitude)
	(put 'angle '(rectangular) angle)
	(put 'make-from-real-imag 'rectangular
		(lambda (x y) (tag (make-from-real-imag x y))))
	(put 'make-from-mag-ang 'rectangular
		(lambda (r a) (tag (make-from-mag-ang r a))))
	'done)

(define (install-polar-package)
;; internal procedures
	(define (magnitude z) (car z))
	(define (angle z) (cdr z))
	(define (make-from-mag-ang r a) (cons r a))
	(define (real-part z)
		(* (magnitude z) (cos (angle z))))
	(define (imag-part z)
		(* (magnitude z) (sin (angle z))))
	(define (make-from-real-imag x y)
		(cons (sqrt (+ (square x) (square y))) (atan y x)))
	;; interface to the rest of the system
	(define (tag x) (attach-tag 'polar x))
	(put 'real-part '(polar) real-part)
	(put 'imag-part '(polar) imag-part)
	(put 'magnitude '(polar) magnitude)
	(put 'angle '(polar) angle)
	(put 'make-from-real-imag 'polar
		(lambda (x y) (tag (make-from-real-imag x y))))
	(put 'make-from-mag-ang 'polar
		(lambda (r a) (tag (make-from-mag-ang r a))))
	'done)

(define (install-complex-package)
	;; imported procedures from rectangular and polar packages
	(define (real-part z)
		(apply-generic 'real-part z))
	(define (imag-part z)
		(apply-generic 'imag-part z))
	(define (magnitude z)
		(apply-generic 'magnitude z))
	(define (angle z)
		(apply-generic 'angle z))
	(define (make-from-real-imag x y)
		((get 'make-from-real-imag 'rectangular) x y))
	(define (make-from-mag-ang r a)
		((get 'make-from-mag-ang 'polar) r a))
	;; internal procedures
	(define (add-complex z1 z2)
		(make-from-real-imag (+ (real-part z1) (real-part z2))
		 (+ (imag-part z1) (imag-part z2))))
	(define (sub-complex z1 z2)
		(make-from-real-imag (- (real-part z1) (real-part z2))
		 (- (imag-part z1) (imag-part z2))))
	(define (mul-complex z1 z2)
		(make-from-mag-ang (* (magnitude z1) (magnitude z2))
		 (+ (angle z1) (angle z2))))
	(define (div-complex z1 z2)
		(make-from-mag-ang (/ (magnitude z1) (magnitude z2))
		 (- (angle z1) (angle z2))))
	;; interface to rest of the system
	(define (tag z) (attach-tag 'complex z))
	(put 'add '(complex complex)
		(lambda (z1 z2) (tag (add-complex z1 z2))))
	(put 'sub '(complex complex)
		(lambda (z1 z2) (tag (sub-complex z1 z2))))
	(put 'mul '(complex complex)
		(lambda (z1 z2) (tag (mul-complex z1 z2))))
	(put 'div '(complex complex)
		(lambda (z1 z2) (tag (div-complex z1 z2))))
	(put 'make-from-real-imag 'complex
		(lambda (x y) (tag (make-from-real-imag x y))))
	(put 'make-from-mag-ang 'complex
		(lambda (r a) (tag (make-from-mag-ang r a))))
	(put 'real-part '(complex) real-part)
	(put 'imag-part '(complex) imag-part)
	(put 'magnitude '(complex) magnitude)
	(put 'angle '(complex) angle)
	'done)
	
(install-complex-package)

(define cnumber1 ((get 'make-from-real-imag 'complex) 5 10))
(define cnumber2 ((get 'make-from-mag-ang 'complex) 2 180))

; This also requires that the complex package is able to have its own selectors interfacing with the representations.
; APPLY-GENERIC is called five times in my case. The first time is when examining the number as just a complex number, then detaching that and getting it again but as a representation number (e.g. rectangular, polar)
; APPLY-GENERIC is dispatched to each case, as the first call deals in the realm of complex numbers, while as the next calls deal with representations of complex numbers.
;
;
;
;
;
;
(define-class (random-generator range)
	(instance-vars (numbers-gen 0))
	(method (number) (set! numbers-gen (+ 1 numbers-gen)) (random range))
	(method (count) numbers-gen))
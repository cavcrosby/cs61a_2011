(define (sum_sq_of_two_numbers x y)
  (+ (square x) (square y)))


(define (square x)
  (* x x))

(define (add_twolarger_ints x y z)
  (if (> x y)
      (if (> y z)
	  (sum_sq_of_two_numbers x y)
	  (sum_sq_of_two_numbers x z))
      (if(> x z)
	 (sum_sq_of_two_numbers x y)
	 (sum_sq_of_two_numbers y z))))
      

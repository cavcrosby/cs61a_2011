(define (sum_of_squares x y)
  (+ (square x) (square y)))


(define (square x)
  (* x x))

(define (sum_of_larger_ints_squared x y z)
  (if (> x y)
      (if (> y z)
		(sum_of_squares x y)
		(sum_of_squares x z))
      (if(> x z) 
		(sum_of_squares x y)
		(sum_of_squares y z))))

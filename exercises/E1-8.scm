(define (cuberoot x) (cube-iter 1.0 x))

(define (cube-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ (+ (/ x (square guess)) (* 2 guess)) 3)))

(define (average x y)
  (/ (+ x y ) 2))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) (* guess .00001)))

(define (square x) (* x x))

(define (cube x) (* x x x))

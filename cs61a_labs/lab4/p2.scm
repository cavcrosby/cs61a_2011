(define x (cons 4 5))
(car x) 
(cdr x)
(define y (cons ’hello ’goodbye))
(define z (cons x y)) 
(car (cdr z)) 
(cdr (cdr z))

(cdr (car z)) ; --> 5
(car (cons 8 3)) ; --> 8
(car z) ; --> (4 . 5)
(car 3) ; error? Not a pair!
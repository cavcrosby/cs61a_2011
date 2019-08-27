(define x (cons 4 5)) ; --> (4 . 5)
(car x) ; --> 4
(cdr x) ; --> 5
(define y (cons ’hello ’goodbye)) ; --> (hello . goodbye)
(define z (cons x y)) ; --> ((4 . 5) hello goodbye) --> actually --> ((4 . 5) hello . goodbye)
(car (cdr z)) ; --> hello
(cdr (cdr z)) ; --> goodbye
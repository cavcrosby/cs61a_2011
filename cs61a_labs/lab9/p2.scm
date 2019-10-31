(define x (cons 1 3))
(define y 2)

; if a student types in (set! (cdr x) y), then Scheme will try and set the expression (cdr x) equal to y, which is not possible (should be noted (cdr x) is not evaluated)
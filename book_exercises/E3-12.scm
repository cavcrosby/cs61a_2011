(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))

; (cdr x) --> b ; x pairs have not been modified, hence we are treat it as 'normal'

(define w (append! x y))

; (cdr w) --> (b c d) ; w will be x's pairs adjoined with y by x's last pair
(define x 2)

(define (fun1 x) (fun2))

(define (fun2) x)

(fun1)

;
; See p5b.lg to run the same code but through Logo. Logo uses dynamic scope, Scheme uses lexical scope.
;
;
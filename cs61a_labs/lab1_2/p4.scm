(define (dupls-removed x)
  (cond((empty? x) '())
      ((member? (first x) (bf x)) (dupls-removed (bf x))) 
      (else (se (first x) (dupls-removed (bf x))))))

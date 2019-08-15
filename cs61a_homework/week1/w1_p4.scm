(define (ordered? x)
  (cond ((empty? (bf x)) #t)
       ((> (first x) (first (bf x))) #f)
       (else (ordered? (bf x)))))


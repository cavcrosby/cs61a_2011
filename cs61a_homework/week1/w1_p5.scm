(define (ends-e x)
  (cond((empty? x) '())
       ((equal? (last (first x)) 'e) (se (first x) (ends-e (bf x))))
       (else (ends-e (bf x)))))

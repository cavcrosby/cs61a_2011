(define (subsent sent i)
  (if(> i 0)
     (subsent (bf sent) (- i 1))
     sent))

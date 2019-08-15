(define (first-satisfies pred sent)
  (cond((empty? sent) #f)
       ((pred (first sent)) (first sent))
       (else (first-satisfies pred (bf sent)))))

(define even? (lambda (x) : (if(> (modulo x 2) 0) #f #t)))

(define (number? x)
  (if(member? x '(-9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9))
     #t
     #f))



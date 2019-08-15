(define (every prod sent)
  (if (empty? sent)
      '()
      (se (prod (first sent)) (every prod (bf sent)))))

(define (square x)
  (* x x))

(define (sum-of-sents sent1 sent2)
  (if (or (empty? sent1) (empty? sent2))
      '()
      (se (+ (first sent1) (first sent2)) (sum-of-sents (bf sent1) (bf sent2))))) 

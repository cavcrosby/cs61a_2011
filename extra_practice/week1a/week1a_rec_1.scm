(define (expt base power)
  (if (= power 0)
      1
      (* base (expt base (- power 1)))))



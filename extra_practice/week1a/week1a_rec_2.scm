(define (count-stairways step_type  n)
  (if (= n 0)
      1
      (* step_type (count-stairways step_type (- n 1)))))



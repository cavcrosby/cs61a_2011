(define (plural wd)
  (if (equal? (last wd) 'y)
      (if (member? (last (bl wd)) '(a e i o u))
	  (word wd 's)
	  (word (bl wd) 'ies))
      (word wd 's)))
	  

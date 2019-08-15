(define (substitute sent old_word new_word)
  (cond ((empty? sent ) '())
	((equal? (first sent) old_word) (se new_word (substitute (bf sent) old_word new_word)))
	(else (se (first sent) (substitute (bf sent) old_word new_word)))))

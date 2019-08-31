(define (substitute list_fp old_word new_word)
    (define (replace sent)
		(cond ((empty? sent) '())
			  ((equal? old_word (first sent)) (se new_word (replace (bf sent))))
			  (else (se (first sent) (replace (bf sent))))))
	(define (substitute-helper list_fp replaced-list old_word new_word)
		(if (empty? list_fp)
			(reverse replaced-list)
			(substitute-helper
				(cdr list_fp)
				(cons (if (word? (car list_fp))
					(car list_fp)
					(replace (car list_fp))) replaced-list)
				old_word
				new_word)))
	(substitute-helper list_fp '() old_word new_word))
	
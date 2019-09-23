(define (substitute list_fp old_word new_word)
	(define (replace sent)
		(cond ((null? sent) '())
			  ((equal? old_word sent) new_word)
			  ((word? sent) sent)
			  ((list? sent) (cons (replace (car sent)) (replace (cdr sent))))
			  (else (cons sent (replace (cdr sent))))))
	(if (null? list_fp)
		'()
		(cons (replace (car list_fp)) (substitute (cdr list_fp) old_word new_word))))
	
(define l '((lead guitar) (bass guitar) (rhythm guitar) drums))

(define (guitar_to_bass lol) (substitute lol 'guitar 'bass))
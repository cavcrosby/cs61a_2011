(define (syllables word)
	(cond ((equal? word "") 0)
		  ((and
				(vowel? (first word))
				(if (equal? (bf word) "") #t (not (vowel? (first (bf word)))))
			(+ 1 (syllables (bf word)))))
		  (else (syllables (bf word)))))
			
			
(define (vowel? letter)
	(member? letter '(a e i o u)))
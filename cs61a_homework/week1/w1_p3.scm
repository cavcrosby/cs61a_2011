(define (switch sent)
  (cond ((empty? sent) '())
		((equal? (switch (bl sent)) '()) ; if we are at the first word in the sentence
			(if (equal? (last sent) 'You)
				'I
				(if (equal? (last sent) 'I)
					'You
					sent)))
		(else (if (equal? (last sent) 'you)
					(se (switch (bl sent)) 'me)
					(if (or (equal? (last sent) 'me) (equal? (last sent) 'I)) ; me or I in this case should be replaced by you since we know its not the first word in the sentence
						(se (switch (bl sent)) 'you)
						(se (switch (bl sent)) (last sent)))))))

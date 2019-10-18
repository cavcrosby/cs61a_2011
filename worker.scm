(define-class (worker)
	(instance-vars (hunger 0))
	(class-vars (all-workers '())
				(work-done 0))
	(initialize (set! all-workers (cons self all-workers)))
	(method (work)
	  (set! hunger (1+ hunger))
	  (set! work-done (1+ work-done))
	  'whistle-while-you-work))
	  
(define-class (TA)
	(parent (worker))
	(method (work)
		(usual 'work)
		'(Let me help you with that box and pointer diagram)) ; assumption is that this value is returned over the parent's returned value from work
	(method (grade-exam) 'A+)
	)

(define inst instantiate)
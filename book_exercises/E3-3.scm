(define (make-account password balance)
	(define (withdraw amount)
		(if (>= balance amount)
			(begin (set! balance (- balance amount))
				balance)
			"Insufficient funds"))
	(define (deposit amount)
		(set! balance (+ balance amount))
			balance)
	(define (dispatch dispatch-password m)
		(if (equal? dispatch-password password)
			(cond ((eq? m 'withdraw) withdraw)
				  ((eq? m 'deposit) deposit)
				  (else (error "Unknown request: MAKE-ACCOUNT" m)))
		    (error "Incorrect Password -- " dispatch-password))) 
	dispatch)
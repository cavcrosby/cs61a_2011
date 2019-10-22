(define (make-account balance)
	(define (withdraw amount)
		(set! balance (- balance amount)) balance)
	(define (deposit amount)
		(set! balance (+ balance amount)) balance)
	(define (dispatch msg)
	 (cond
		((eq? msg 'withdraw) withdraw)
		((eq? msg 'deposit) deposit)
		((eq? msg 'balance) balance) ))
	 dispatch)
	 
(define (make-account init-amount)
	(let ((balance init-amount) (init-balance init-amount)) ; let just needed to take the local var init-amount and put it into the let as balance
		(define (withdraw amount)
			(set! balance (- balance amount)) balance)
		(define (deposit amount)
			(set! balance (+ balance amount)) balance)
		(define (dispatch msg)
			(cond
				((eq? msg 'withdraw) withdraw)
				((eq? msg 'deposit) deposit) 
				((eq? msg 'balance) balance) ))
	dispatch) )
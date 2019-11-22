(define (transfer from-account to-account amount)
	((from-account 'withdraw) amount)
	((to-account 'deposit) amount))

; Louis is correct as the following procedure would be prone to deadlocks.
; Lets say I have process A and B, A arguments (besides amount which is not really relevant) being me you, B arguments being you me.
; Eventually there could come a point when A needs 'you' but B is waiting on A to release 'me', thus resulting in deadlock.
;
; Going back to the example above, if we determine that the order of acquiring the bank accounts must start with 'me' first then 'you', this would avoid deadlock.
; In general, an order of acquiring resources (however complex) can solve the deadlock problem.

; 
;
;
;

(define (make-serializer)
	(let ((mutex (make-mutex)))
		(lambda (p)
			(define (serialized-p . args)
				(mutex 'acquire)
				(let ((val (apply p args)))
					(mutex 'release)
						val))
			serialized-p)))
			
(define (make-mutex)
	(let ((cell (list false)))
		(define (the-mutex m)
			(cond ((eq? m 'acquire)
				  (if (test-and-set! cell)
					  (the-mutex 'acquire))) ; retry
				  ((eq? m 'release) (clear! cell))))
			the-mutex))

(define (clear! cell) (set-car! cell false))

(define (test-and-set! cell)
	(if (car cell) true (begin (set-car! cell true) false)))

(define make-account-and-serializer
	(let ((account_number 1))
		(lambda (balance)
			(let ((acc_num account_number))
				(define (withdraw amount)
					(if (>= balance amount)
						(begin (set! balance (- balance amount))
							balance)
						"Insufficient funds"))
				(define (deposit amount)
					(set! balance (+ balance amount))
					balance)
				(let ((balance-serializer (make-serializer)))
					(define (dispatch m)
						(cond ((eq? m 'withdraw) withdraw)
							  ((eq? m 'deposit) deposit)
							  ((eq? m 'balance) balance)
							  ((eq? m 'serializer) balance-serializer)
							  ((eq? m 'number) acc_num)
							  (else (error "Unknown request: MAKE-ACCOUNT" m))))
					(set! account_number (+ 1 account_number)) dispatch)))))
					
(define (exchange account1 account2)
	(let ((difference (- (account1 'balance) (account2 'balance))))
			((account1 'withdraw) difference) 
			((account2 'deposit) difference)))

(define (serialized-exchange account1 account2)
	(define (seh smaller-account larger-account)
		(let ((serializer1 (smaller-account 'serializer))
			(serializer2 (larger-account 'serializer)))
				((serializer1 (serializer2 exchange)) smaller-account larger-account)))
	(let ((larger (if (> (account1 'number) (account2 'number)) account1 account2)) 
			(smaller (if (< (account1 'number) (account2 'number)) account1 account2)))
				(seh smaller larger)))

(define acc1 (make-account-and-serializer 500))
(define acc2 (make-account-and-serializer 200))
(define acc3 (make-account-and-serializer 100))

(define pe parallel-execute)
(define se serialized-exchange)
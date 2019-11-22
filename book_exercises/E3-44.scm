(define (transfer from-account to-account amount)
	((from-account 'withdraw) amount)
	((to-account 'deposit) amount))

;
; Louis is correct as the following procedure would be prone to deadlocks.
; Lets say I have process A and B, A arguments (besides amount which is not really relevant) being me you, B arguments being you me.
; Eventually there could come a point when A needs 'you' but B is waiting on A to release 'me', thus resulting in deadlock.
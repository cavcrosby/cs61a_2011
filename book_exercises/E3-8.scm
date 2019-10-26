(define f
	(let ((instance-var 'none))
		(lambda (num)
			(if (equal? instance-var 'none) 
				(begin (set! instance-var num) num)
				(begin (set! instance-var 'none) 0)))))
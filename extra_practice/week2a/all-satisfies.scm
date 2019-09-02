(define (all-satisfies sen pred)
	(if (equal? sen (keep pred sen)) #t #f))
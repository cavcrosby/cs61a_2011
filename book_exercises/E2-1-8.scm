(define (reverse list_fp)
	(cond ((empty? (current-pair-next-points-to list_fp)) (adjoin (car list_fp)))
		  ;((empty? (next-to-last-pair list_fp)) (car list_fp))
		  (else (((adjoin-combined-pairs 
				((lambda (g) (lambda (p) (lambda (next-next-pair) (g (cons p next-next-pair)))))(current-pair-value-points-to list_fp)) (reverse (current-pair-next-points-to list_fp)))
				)))))

	
(define current-pair-value-points-to car)
(define current-pair-next-points-to cdr)

(define (adjoin first_pair) (lambda (next_pair) (cons first_pair next_pair)))
;((lambda (first_pair) : (lambda (next_pair) (cons first_pair next_pair))) (car list_fp))

(define (adjoin-combined-pairs combined-pairs) (lambda (next-next-pair) ((combined-pairs next-next-pair))))
;((lambda (combined_pairs): (lambda (next_pair) (cons combined_pairs next_pair))) 
;					((reverse (current-pair-next-points-to list_fp)) (current-pair-value-points-to list_fp)))

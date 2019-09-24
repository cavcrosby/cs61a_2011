(define (substitute2 list_fp old_word_list new_word_list)
    (define (replace sent)
		(cond ((empty? sent) '())
			  ((member? (first sent) old_word_list) (se (nth (index old_word_list (first sent)) new_word_list) (replace (bf sent))))
			  (else (se (first sent) (replace (bf sent))))))
	(define (substitute-helper list_fp replaced-list)
		(if (empty? list_fp)
			(reverse replaced-list)
			(substitute-helper
				(cdr list_fp)
				(cons (if (word? (car list_fp))
					(car list_fp)
					(replace (car list_fp))) replaced-list))))
	(substitute-helper list_fp '()))
	
(define (index sent element)
	(define (index-helper sent int)
		(cond ((empty? sent) 0)
			  ((equal? element (first sent)) int)
			  (else (index-helper (bf sent) (+ int 1)))))
	(index-helper sent 0))

(define l1 '((4 calling birds) (3 french hens) (2 turtle doves)))

(define l2 '(1 2 3 4))

(define l3 '(one two three four))

(define s substitute2)

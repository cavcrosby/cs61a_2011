;; constructor

(define (make-queue) (cons '() '()))


;; selectors

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (front-queue queue)
	(if (empty-queue? queue)
		(error "FRONT called with an empty queue" queue)
		(car (front-ptr queue))))

;; mutators 
(define (set-front-ptr! queue item)
	(set-car! queue item))
(define (set-rear-ptr! queue item)
	(set-cdr! queue item))
	
(define (insert-queue! queue item)
	(let ((new-pair (cons item '())))
	  (cond ((empty-queue? queue)
				(set-front-ptr! queue new-pair)
				(set-rear-ptr! queue new-pair)
				(print-queue queue))
			(else
				(set-cdr! (rear-ptr queue) new-pair)
				(set-rear-ptr! queue new-pair)
				(print-queue queue)))))
				
(define (delete-queue! queue)
	(cond ((empty-queue? queue)
				(error "DELETE! called with an empty queue" queue))
		  (else (set-front-ptr! queue (cdr (front-ptr queue)))
				(print-queue queue))))
	
;; utility funcs

(define (empty-queue? queue)
	(null? (front-ptr queue)))
	
(define (print-queue queue)
	(print (front-ptr queue)))

; When scheme normally prints the representation of the pair, the first pointer points to a seqeuence of elements (or the queue), while the second pointer points to another seqeuence (of one pair)
; These two pointers being conjoined in a pair by cons, can help explain why scheme normally prints the elements this way
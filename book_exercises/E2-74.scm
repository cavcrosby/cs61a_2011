(define (install-division-package)

	; Hierarchy Of Types
	
	(define types '(organization division emp-record attr))
	
	; constructors
		
	; (define (make-organization . divisions) (list divisions)) ; no name for organization
	
	; (define (make-personnel-file . emp-records) (make emp-records)) ; division . emp-records

	; (define (make-emp-record . attrs) (make attrs)) ; emp . emp-attrs

	; (define (make-attr . args) (make args)) ; attr attr-value
	
	; predicates
	
	(define (subtype? element-type in-element-type)
		(equal? (index-of in-element-type types) (- (index-of element-type types) 1)))
	; if element-type is division, while in-element-type is organization then it should return #t
	; organization index is 0, division index is 1 (based on the tower)
	
	(define (valid-types? element in-element)
		(let ((in-element-type (type-tag in-element)) (element-type (type-tag element)))
			 (cond ((equal? (index-of types in-element-type) -1) #f) 
				   ((equal? (index-of types element-type) -1) #f)
				   (else #t))))
				   
				   
	(define (exist-in? element in-element)
		(cond ((not (valid-types? element in-element)) (error "Unknown type(s) -- exist-in:" element in-element))
			  ((not (subtype? element in-element)) (error "Element is not subtype in-element -- exist-in:" element in-element))
			  (else (find element in-element))))
				   
	; selectors
	
	(define get-element car)
	
	(define identifier car)
	
	(define rest-of cdr)
	
	(define type-tag car)
	
	(define (get-record division emp-record)
		(let ((emp-record-found (exist-in? emp-record division)))
			(if emp-record-found
				emp-record-found
				(error "Employee record does not exist -- get-record:" division emp-record))))
	
	; utility
	
	(define (index-of lst x)
		(define (index-of-helper lst count)
			(cond ((null? lst) -1)
				  ((eq? (car lst) x) count)
				  (else (+ (index-of-helper (cdr lst) (+ 1 count))))))
	  (index-of-helper lst 0))
	
	(define (find element in-element)
		(cond ((null? in-element) '())
			  ((equal? element (identifier (get-element in-element))) (get-element in-element))
			  (else (find element (rest-of in-element)))))
	
	;; interface to rest of the system
	(define (tag type e) (attach-tag type e))
	(put 'make '(organization)
		(lambda (. divisions) (tag 'organization (list divisions))))
	(put 'make '(division)
		(lambda (. emp-records) (tag 'division (list emp-records))))
	(put 'make '(emp-record)
		(lambda (. emp-attrs) (tag 'emp-record (list emp-attrs))))
	(put 'make '(attr)
		(lambda (. attr-value) (tag 'attr (list attr-value))))
	(put 'get-record '(emp-record)
		(lambda (record division) (get-record record division)))
'done)






; package install
(install-division-package)

(define attr1 ((get 'make '(attr)) 'Salary '50000))
(define attr2 ((get 'make '(attr)) 'Address '(298 Smith Road)))

(define emp-record ((get 'make '(emp-record)) "Conner" attr1 attr2))

(define division ((get 'make '(division)) "Alpha" emp-record))

(define the-cool-guys ((get 'make '(organization)) division))

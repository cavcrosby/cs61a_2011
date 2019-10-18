(define (install-division-package)

	; Hierarchy Of Types
	
	(define types '(
		(organization) 
		(division) 
		(emp-record) 
		(attr)))
	
	; selectors for constructors
	
	(define associate cons)
	
	(define wrap list)
	
	; constructors
		
	(define (make-organization identifier . divisions) (associate identifier divisions)) ; organization is the highest data strucutre, no need to have organizations
	; (organization 'identifier' (list of divisions))
	
	(define (make-division identifier . records) (associate identifier records)) ; divisions are a personel file, (division 'identifier' (list of emp-records))

	(define (make-emp-record identifier . attrs) (associate identifier attrs)) ; (emp-record 'identifier' (list of attrs))

	(define (make-attr identifier attr-value) (wrap identifier attr-value)) ; (attr ('identifier' attr-value))
	
	; predicates
	
	(define (subtype? type container-type)
		(<= (index-of types container-type) (index-of types type)))
	
	(define (of-requested-type? type container-type)
		(equal? type container-type))
		
	(define (one-item? container)
		(equal? (length container) 3)) ; (data-object identifier data) we only have one data item of the data-object
	
	; selectors
	
	(define get-identifier cadr)
	
	(define container-contents caaddr)
	
	; TODO ADD TRANSFORM FUNC FOR OTHERS TO USE?
			   
			   
	(define (get-generic type-desired container identifier) ; container should be of a specfic data object type, so all divisions, emp-records, or attributes
		(cond  ((not (subtype? type-desired (type-tag container))) (error "Container passed is a subtype, cannot get desired data -- " (type-tag container)))
			   ((not (of-requested-type? type-desired (type-tag container))) 
			     (apply append 
						(map (lambda (content) (get-generic type-desired content identifier)) (container-contents container))
						))
			   (else (find identifier container))))
				
	; utility
	
	(define (index-of lst x)
		(define (index-of-helper lst count)
			(cond ((null? lst) -1)
				  ((equal? (car lst) (list x)) count) ; all types are in braces e.g. (organization)
				  (else (index-of-helper (cdr lst) (+ 1 count)))))
	  (index-of-helper lst 0))
	
	(define (find identifier container-row)
		(if (equal? identifier (get-identifier container-row))
			(wrap container-row)
			'()))
			  
	
	;; interface to rest of the system
	(define (tag type e) (attach-tag type e))
	(put 'make '(organization)
		(lambda (identifier . divisions) (tag 'organization (make-organization identifier divisions))))
	(put 'get-data '(organization)
		(lambda (organization identifier) (get-generic 'organization organization identifier)))
	(put 'make '(division)
		(lambda (identifier . emp-records) (tag 'division (make-division identifier emp-records))))
	(put 'get-data '(division)
		(lambda (division identifier) (get-generic 'division division identifier)))
	(put 'make '(emp-record)
		(lambda (identifier . emp-attrs) (tag 'emp-record (make-emp-record identifier emp-attrs))))
	(put 'get-data '(emp-record)
		(lambda (emp-record identifier) (get-generic 'emp-record emp-record identifier)))
	(put 'make '(attr)
		(lambda (identifier attr-value) (tag 'attr (make-attr identifier attr-value))))
	(put 'get-data '(attr)
		(lambda (identifier value) (get-generic 'attr identifier value)))
	(put 'get-identifier '(organization)
		get-identifier)
'done)

; package install
(install-division-package)

; interface procedures
		
(define (make-organization identifier . data)
	((get 'make '(organization)) identifier data))
	
(define (make-division identifier . data)
	((get 'make '(division)) identifier data ))
	
(define (make-emp-record identifier . data)
	((get 'make '(emp-record)) identifier data))
	
(define (make-attr identifier data)
	((get 'make '(attr)) identifier data))

;a
(define (get-record type-desired data identifier)
	(let ((func (get 'get-data (append (list type-desired) '()))))
		(if func
			(func data identifier)
			(error "Unknown type of record to get -- get-record: " type-desired))))
			
;b			
(define (get-salaries emp div)
		(apply append (map (lambda (emp-record) (get-record 'attr emp-record 'salary)) (get-record 'emp-record div emp))))
;c			
(define (find-employee-record emp org)
		(get-record 'emp-record org emp))
	
;d
;The only change to be made, will be that the new company will need to be added as a new division to Insatiable

;;;;;;;;

(define attr1 (make-attr 'Salary '50000))
(define attr2 (make-attr 'Address '(298 Smith Road)))

(define emp-record (make-emp-record 'Conner attr1 attr2))

(define attr3 (make-attr 'Salary '70000))
(define attr4 (make-attr 'Address '(123 Bob Road)))

(define emp2-record (make-emp-record 'William attr3 attr4))

(define attr5 (make-attr 'Salary '30000))
(define attr6 (make-attr 'Address '(123 Smith Road)))

(define emp3-record (make-emp-record 'Conner attr5 attr6))

(define division (make-division 'Alpha emp-record emp2-record emp3-record))

(define org (make-organization 'the-cool-guys division))

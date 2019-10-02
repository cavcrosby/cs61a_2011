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
	
	(define (coercion? type container-type)
		(>= (index-of types container-type) (index-of types type)))
	
	(define (valid-type? type)
		(if (equal? (index-of types type) -1) #t #f))
			 
	(define (of-requested-type? type container-type)
		(equal? type container-type))
		
	(define (one-item? container)
		(equal? (length container) 3)) ; (data-object identifier data) we only have one data item of the data-object
	
	; selectors
	
	(define get-identifier cadr)
	
	(define get-identifier-attr caadr)
	
	(define type-tag car)
	
	(define rest-of cdr)
	
	(define sub-type-contents caddr)
	
	; TODO ADD GETTERS FOR SUBTYPES, CONTENTS JUST GIVES ME THE DATA, E.G (cdar (contents org)) gives me the divisions
	; ADD TRANSFORM FUNC FOR OTHERS TO USE?
	
	(define (get-record type-desired container identifier) ; container should be of a specfic data object type, so all divisions, emp-records, or attributes
		(cond ((not (valid-type? type-desired)) (error "Unknown type of record to get -- get-record:" type))
			  ((and ; if we don't have the right data and we can perform coercion on the data, try again
				(not (of-requested-type? 
						type-desired 
						(type-tag container)))
				(coercion? 
					type-desired 
					(type-tag container)))
						(apply append (map (lambda (subtype) (get-record type-desired subtype identifier)) (sub-type-contents container))))
			  ((not (of-requested-type? type-desired (type-tag container))) '()) ; if we get to the bottom data type with no results, return '()
			  (else (list (find identifier container)))))
	
	; utility
	
	(define (index-of lst x)
		(define (index-of-helper lst count)
			(cond ((null? lst) -1)
				  ((eq? (car lst) x) count)
				  (else (+ (index-of-helper (cdr lst) (+ 1 count))))))
	  (index-of-helper lst 0))
	
	(define (find identifier container-row)
		(cond ((null? container-row) '())
			  ((and (equal? (type-tag container-row) 'attr) (equal? identifier (get-identifier-attr container-row))) container-row)
			  ((and (not (equal? (type-tag container-row) 'attr)) (equal? identifier (get-identifier container-row))) container-row)
			  (else (find identifier (rest-of container-row)))))
	
	;; interface to rest of the system
	(define (tag type e) (attach-tag type e))
	(put 'make '(organization)
		(lambda (identifier . divisions) (tag 'organization (make-organization identifier divisions))))
	(put 'get-data '(organization)
		(lambda (organization identifier) (get-record 'organization organization identifier)))
	(put 'make '(division)
		(lambda (identifier . emp-records) (tag 'division (make-division identifier emp-records))))
	(put 'get-data '(division)
		(lambda (division identifier) (get-record 'division division identifier)))
	(put 'make '(emp-record)
		(lambda (identifier . emp-attrs) (tag 'emp-record (make-emp-record identifier emp-attrs))))
	(put 'get-data '(emp-record)
		(lambda (emp-record identifier) (get-record 'emp-record emp-record identifier)))
	(put 'make '(attr)
		(lambda (identifier attr-value) (tag 'attr (make-attr identifier attr-value))))
	(put 'get-data '(attr)
		(lambda (identifier value) (get-record 'attr identifier value)))
'done)






; package install
(install-division-package)

; interface procedures

(define (make-organization-data type data identifier)
	((get 'make (append (list type) '())) data identifier))

(define (get-record type data identifier)
	((get 'get-data (append (list type) '())) data identifier))
	
;;;;;;;;

(define attr1 ((get 'make '(attr)) 'Salary '50000))
(define attr2 ((get 'make '(attr)) 'Address '(298 Smith Road)))

(define emp-record ((get 'make '(emp-record)) 'Conner attr1 attr2))

(define division ((get 'make '(division)) 'Alpha emp-record))

(define org ((get 'make '(organization)) 'the-cool-guys division))

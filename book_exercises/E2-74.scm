(define (install-division-package)

	; Hierarchy Of Types
	
	(define types '(
		(organization) 
		(division) 
		(emp-record) 
		(attr)))
	
	; selectors for constructors
	
	(define assoicate cons)
	
	(define wrap list)
	
	; constructors
		
	(define (make-organization identifier . divisions) (wrap (assoicate identifier divisions)))
	
	(define (make-division identifier . records) (wrap (assoicate identifier records))) ; divisions are a personel file

	(define (make-emp-record identifier . emp-record) (wrap (assoicate identifier emp-record)))

	(define (make-attr identifier attr-value) (wrap (list identifier attr-value)))
	
	; predicates
	
	(define (subtype? type container-type)
		(>= (index-of types container-type) (index-of types type)))
	
	(define (valid-type? type)
		(if (equal? (index-of types type) -1) #t #f))
			 
	(define (of-requested-type? type container-type)
		(equal? type container-type))
	
	; selectors
	
	(define get-element car)
	
	(define get-identifier car)
	
	(define rest-of cdr)
	
	(define type-tag car)
	
	; TODO ADD GETTERS FOR SUBTYPES, CONTENTS JUST GIVES ME THE DATA, E.G (cdar (contents org)) gives me the divisions
	; ADD TRANSFORM FUNC FOR OTHERS TO USE?
	
	
	(define (get-record type container identifier)
		(cond ((not (valid-type? type)) (error "Unknown type -- get-record:" type))
			  ((and 
				(not (of-requested-type? type (type-tag container)))
				(subtype? type (type-tag container)))
					(get-record type (contents container) identifier))
		      ((not (of-requested-type? type (type-tag container))) (error "Bad data object -- " (type-tag container))) 
			  (else (find identifier container))))
	
	; utility
	
	(define (index-of lst x)
		(define (index-of-helper lst count)
			(cond ((null? lst) -1)
				  ((eq? (car lst) x) count)
				  (else (+ (index-of-helper (cdr lst) (+ 1 count))))))
	  (index-of-helper lst 0))
	
	(define (find identifier container)
		(cond ((null? container) '())
			  ((equal? identifier (get-identifier (get-element container))) (get-element container))
			  (else (find identifier (rest-of container)))))
	
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

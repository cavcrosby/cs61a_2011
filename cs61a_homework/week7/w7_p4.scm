(define-class (person name)
  (method (say stuff) stuff)
  (method (ask stuff) (ask self 'say (se '(would you please) stuff))) 
  )
  
(define-class (miss-manners obj)
(method (please msg1 agr1)
	(ask obj msg1 agr1)))
  
; (1 3 (5 7) 9)

(define list1 '(1 3 (5 7) 9))
(define result1 (car (cdr (car (cdr (cdr list1))))))

; ((7))

(define list2 '((7)))
(define result2 (car (car list2)))

; (1 (2 (3 (4 (5 (6 7))))))

(define list3 '(1 (2 (3 (4 (5 (6 7)))))))
(define result3 (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr list3)))))))))))))
; I agree with Ben's modification. In particular, lets say a concurrent deposit and withdrawal are occuring on the same account. 
; The deposit method could read the balance, only to have the balance be read and set by the withdrawal method. This would lead to a incorrect result (this would negate the fact a withdrawal happened).
;
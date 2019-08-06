;If applicative-order evaluation is used, then when the expression evaluates, it will end up in an infinite recursion trying to evaluate the argument ‘p’. 
;If normal-order evaluation is used, then the (actual) arguments themselves will not be evaluated first but inserted into the procedure application and then the predicate expression will be called returning 0, instead of calling ‘p’. 
;This is because in normal order, the arguments are not evaluated until they are needed.
;

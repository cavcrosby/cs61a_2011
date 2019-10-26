; the local state for acc is kept in the first new env generated that is not the global env
; The local states are kept separate by making sure their balances are in different envs
; Withdraw, deposit, and the dispatch procedures (not their envs other than the global env) are shared between the two accounts
;
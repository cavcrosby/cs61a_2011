;a
;Possible values include: (assuming the system forces the processes to run sequentially)
;$45 $35 $40 $50
;
;b
;Other values include:
;
;$50 (Mary's process is the last one to set the balance, after Paul and Peter have read and set)
;$80 (Paul's process is the last one to set the balance, after Peter and Mary have read and set)
;$110 (Peter's process is the last one to set the balance, after Paul and Mary have read and set)
;$40 (Peter and Paul's process reads the balance but Paul's is the last to set then Mary executes her process) (interestly a correct value if done sequentially)
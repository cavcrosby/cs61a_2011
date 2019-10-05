;#For generic operations with explicit dispatch (conventional interfaces):
;For every new type, it will need a corresponding operation for all operators
;For each new operation, it will just need to have the generic interface added with all the operations for the types
;
;#For data directed programming:
;For every new type, its procedures will need to be defined and added to the table
;For every new operation, it will need to be added to the table per each type
;BEST USED ON SYSTEMS THAT ADD NEW TYPES AND OPERATIONS
;
;#For messaging passing:
;For every new type, it will be a new function with each of its operations
;For every new opertion, it will need to be added to each data object function
;BEST USED ON SYSTEMS THAT ADD NEW OPERATIONS
;
;
;
;
;
;
;
;
;
;
;
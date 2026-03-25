;; a5q1a.asm
;
;; Name: Talha Yildirim
;; Quest ID: 21014743
;;
;; Description: Implementation of the filter subroutine. Accepts a predicate
;; function, an array address, and the array size. Produces a new array
;; (placed in memory immediately after the original) containing only the
;; elements for which the predicate returns true (1).
;
;; SUBROUTINE: filter
;
;; Input:  $4 = address of a predicate function
;;              (the predicate takes one argument in $4, returns 1 or 0 in $2)
;;         $5 = address of the first element of the original array
;;         $6 = size of the original array (number of elements)
;;
;; Output: $2 = address of the first element of the new (filtered) array
;;         $3 = size of the new array
;;
;; Behaviour:
;;   - Iterates over each element of the original array.
;;   - Calls the predicate function on each element.
;;   - If the predicate returns 1, the element is copied to the new array.
;;   - The new array is written to memory immediately after the original array.
;;
;; Register conventions:
;;   filter is both a CALLEE (called by main) and a CALLER (calls predicate).
;;   As a callee it must save/restore any saved registers ($16-$23) it uses,
;;   plus $31 (since jalr to the predicate overwrites $31).
;;   As a caller it cannot trust temporary registers ($8-$15, $24, $25) to
;;   survive the predicate call, so important values are kept in saved regs
;;   or pushed onto the stack.
;;
;; Saved register allocation:
;;   $16 = address of the predicate function (preserved across predicate calls)
;;   $17 = read pointer -- current position in the original array
;;   $18 = end of original array address (= start of new array)
;;   $19 = write pointer -- current position in the new array
;;   $20 = counter for the number of elements in the new array

filter:

;; Save callee-saved registers and $31 onto the stack
sw $31, -4($30)            
sw $16, -8($30)            
sw $17, -12($30)           
sw $18, -16($30)           
sw $19, -20($30)           
sw $20, -24($30)           
addi $30, $30, -24         ; move stack pointer down by 24 bytes

;; Copy arguments into saved registers 
add $16, $4, $0            ; $16 predicate function address
add $17, $5, $0            ; $17 read pointer (start of original array)

;; Calculate the address one past the end of the original array.
lis $8                     
.word 4
mult $6, $8               
mflo $8                   
add $18, $5, $8            

;; Initialise the write pointer and new-array size counter.
add $19, $18, $0           
add $20, $0, $0            

;; Iterate over each element of the original array 
filterLoop:

;; Check termination: if read pointer has reached the end, we are done.
beq $17, $18, filterDone   

;; Load the current element from the original array.
lw $8, 0($17)              

;; Save the current element on the stack before calling the predicate,
;; because the predicate is free to clobber all temporary registers ($8-$15).
sw $8, -4($30)             
addi $30, $30, -4          

;; Call the predicate function with the current element as its argument.
;; The predicate expects its single argument in $4 and returns 1/0 in $2.
add $4, $8, $0             
jalr $16                   

;; Restore the current element from the stack (predicate may have changed $8).
addi $30, $30, 4          
lw $8, -4($30)           

;; Check the predicate's return value.
beq $2, $0, filterSkip     

;; Predicate returned 1: copy the element into the new array
sw $8, 0($19)              
addi $19, $19, 4           
addi $20, $20, 1           

filterSkip:

;; Advance the read pointer to the next element in the original array.
addi $17, $17, 4           
beq $0, $0, filterLoop     

;; Set return values and restore saved registers 
filterDone:

;; Return values:
add $2, $18, $0            ; $2 = new array start address
add $3, $20, $0            ; $3 = new array size

;; Restore all callee-saved registers and $31 from the stack.
addi $30, $30, 24          
lw $20, -24($30)           
lw $19, -20($30)           
lw $18, -16($30)           
lw $17, -12($30)           
lw $16, -8($30)            
lw $31, -4($30)            

jr $31                     

;; a5q1b.asm
;;
;; Name: Talha Yildirim
;; Quest ID: 21014743
;;
;; Description: Main program that uses the filter subroutine to produce a new
;; array containing only the values from the original array that are valid
;; MIPS word-aligned addresses (non-negative multiples of 4).
;; Uses the array front end: $1 = address of first element, $2 = size.
;; On exit: $1 = address of new filtered array, $2 = size of new array.
;;

;; MAIN PROGRAM


;; Save $31 (return address) on the stack.
sw $31, -4($30)
addi $30, $30, -4         

;; Set up the three arguments for the filter subroutine:
;;   $4 = address of the predicate function (wordaligned)
;;   $5 = address of the first element of the array (currently in $1)
;;   $6 = size of the array (currently in $2)
lis $4                     
.word wordaligned          
add $5, $1, $0             
add $6, $2, $0

;; Call the filter subroutine.
;; After it returns:
;;   $2 = address of the first element of the newly created filtered array
;;   $3 = size of the newly created filtered array
lis $8                    
.word filter
jalr $8                    

;; Move filter's return values into the registers the array front end expects:
;;   $1 = address of the new array
;;   $2 = size of the new array
;; We must copy $2 first (into $1) before overwriting $2 with $3.
add $1, $2, $0
add $2, $3, $0

;; Restore $31 from the stack so we can return to the caller.
addi $30, $30, 4           
lw $31, -4($30)           

jr $31                     ; return to the OS / array front end

;; Subroutine: wordaligned
;
;; Determines whether a given integer is a valid MIPS word address,
;; i.e. a non-negative multiple of 4.
;;
;; Input:  $4 = the integer to test
;; Output: $2 = 1 if $4 >= 0 AND $4 mod 4 == 0
;;         $2 = 0 otherwise
;;
;; Examples: wordaligned(12)   = 1   (12 >= 0 and 12 mod 4 == 0)
;;           wordaligned(1000) = 1
;;           wordaligned(0)    = 1   (0 is non-negative and 0 mod 4 == 0)
;;           wordaligned(-4)   = 0   (negative)
;;           wordaligned(15)   = 0   (15 mod 4 == 3, not divisible by 4)
;;
;; Register usage (all unsaved temps -- no callee-saves needed):
;;   $2 = return value / temp for slt result
;;   $8 = temporary for divisor and remainder

wordaligned:

;; Step 1: Check if $4 is negative.
;; slt sets $2 = 1 if $4 < 0, else $2 = 0.
slt $2, $4, $0             
bne $2, $0, notwaligned    

;; Step 2: $4 is non-negative. Check divisibility by 4.
;; Compute $4 mod 4. If remainder is 0, the number is word-aligned.
lis $8              
.word 4
div $4, $8           
mfhi $8               
bne $8, $0, notwaligned

;; Both checks passed: $4 is a non-negative multiple of 4.
lis $2                  
.word 1
jr $31                   

notwaligned:
;; Either $4 was negative or not divisible by 4.
add $2, $0, $0            
jr $31                     


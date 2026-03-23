; a4q1.asm
;
; Name: Talha Yildirim
; Quest ID: 21014743
;
; Description: Finds the minimum and maximum values of an integer array,
;   stores them in $3 (min) and $4 (max), then replaces each element
;   with -1 (closer to min), 1 (closer to max), or 0 (equidistant).
;
; Register usage:
; $1  - array base address 
; $2  - array length 
; $3  - minimum value of the array 
; $4  - maximum value of the array
; $5  - constant 4 
; $6  - one-past-end address of array ($1 + $2*4)
; $7  - current element address (loop pointer)
; $8  - current element value / replacement value (-1, 0, 1)
; $9  - temporary result of slt comparisons
; $10 - distance from current element to minimum 
; $11 - distance from current element to maximum

; Initialize min ($3) and max ($4) with arr[0]
lw $3, 0($1)
lw $4, 0($1)

; $5 = 4 (byte stride between words)
addi $5, $0, 4

; $6 = end address = $1 + $2*4  (first address past the array)
mult $2, $5
mflo $6
add $6, $6, $1

; Frist step find max and min
; Start at arr[1]: $7 = $1 + 4
addi $7, $1, 4

findmm:
  beq $7, $6, donefindmm    ; reached end, stop

  lw $8, 0($7)              ; $8 = arr[i]

  ; if $8 < $3 (current min), update min
  slt $9, $8, $3
  beq $9, $0, checkmax
  add $3, $8, $0            ; $3 = $8 (new min)

checkmax:
  ; if $4 < $8 (current max < element), update max
  slt $9, $4, $8
  beq $9, $0, nextfind
  add $4, $8, $0            ; $4 = $8 (new max)

nextfind:
  addi $7, $7, 4            ; advance to next element
  beq $0, $0, findmm

donefindmm:

; Second step set to one of [0, 1, -1]
; Reset address pointer to arr[0]
add $7, $1, $0

replacelp:
  ; reached end, stop
  beq $7, $6, donereplace   

  ; $8 = arr[i]
  lw $8, 0($7)              

  ; dist_to_min = elem - min  
  sub $10, $8, $3

  ; dist_to_max = max - elem  
  sub $11, $4, $8

  ; if dist_to_min < dist_to_max store 1 
  slt $9, $10, $11
  beq $9, $0, trypos

  ; $8 = -1  
  addi $8, $0, -1      
  sw $8, 0($7)
  beq $0, $0, nextrep

trypos:
  ; if dist_to_max < dist_to_min store 1 
  slt $9, $11, $10
  beq $9, $0, storezero

  ; $8 = 1
  addi $8, $0, 1            
  sw $8, 0($7)
  beq $0, $0, nextrep

storezero:
  ; distances are equal, store 0
  sw $0, 0($7)

nextrep:
  ; advance to next element
  addi $7, $7, 4            
  beq $0, $0, replacelp

donereplace:
  jr $31


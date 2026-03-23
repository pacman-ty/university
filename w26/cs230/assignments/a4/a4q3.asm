; a4q3.asm
;
; Name: Talha Yildirim
; Quest ID: 21014743
;
; Description: Reads an "out of" total from standard input, then iterates
;   over an integer array of marks (base in $1, length in $2) and prints
;   a letter grade for each mark: A (>=80%), B (>=70%), C (>=60%),
;   D (>=50%), F (<50%). Ends with a newline character.
;
; Register usage:
; $1  - array base address (input, not modified)
; $2  - array length (input, not modified)
; $5  - stdin address  (0xffff0004)
; $6  - stdout address (0xffff000c)
; $7  - newline constant (10 = 0xA)
; $8  - temporary: current byte / grade character / slt operand
; $9  - constant 10 (used as decimal base when parsing "out of" integer)
; $11 - the "out of" value read from stdin
; $12 - loop index (0 to $2-1)
; $13 - current mark value, then holds computed percentage
; $14 - current element address (walks through the array)
; $15 - result of slt comparisons for grade thresholds

; Intiliaze constants 
lis $5
.word 0xffff0004          ; stdin

lis $6
.word 0xffff000c          ; stdout

addi $7, $0, 10           ; newline = ASCII 0xA

addi $9, $0, 10           ; decimal base 10 (for parsing the "out of" integer)


; $11 = out_of = 0 for now 
add $11, $0, $0           

readout:
  lw $8, 0($5)         
  beq $8, $7, doneout 
  addi $8, $8, -48   
  mult $11, $9      
  mflo $11         
  add $11, $11, $8
  beq $0, $0, readout

doneout:

; Loop through array and print one letter grade per mark 
add $12, $0, $0           ; $12 = index = 0
add $14, $1, $0           ; $14 = &arr[0]

gradelp:
  ; processed all elements
  beq $12, $2, donegrade  

  ; $13 = mark
  lw $13, 0($14)          

  ; Compute percentage = floor((mark * 100) / out_of)
  ; This perserves accuracy 
  lis $8
  .word 100
  mult $13, $8         
  mflo $13            
  div $13, $11       
  mflo $13          

  ; Check A
  addi $8, $0, 80
  slt $15, $13, $8        
  bne $15, $0, notA
  addi $8, $0, 65    
  sw $8, 0($6)            ; ASCII 'A' 
  beq $0, $0, nextelm

notA:
  ; Check B 
  addi $8, $0, 70
  slt $15, $13, $8        
  bne $15, $0, notB
  addi $8, $0, 66         ; ASCII 'B' 
  sw $8, 0($6)
  beq $0, $0, nextelm

notB:
  ; Check C
  addi $8, $0, 60
  slt $15, $13, $8        
  bne $15, $0, notC
  addi $8, $0, 67         ; ASCII 'C' 
  sw $8, 0($6)
  beq $0, $0, nextelm

notC:
  ; Check D
  addi $8, $0, 50
  slt $15, $13, $8       
  bne $15, $0, notD
  addi $8, $0, 68       
  sw $8, 0($6)
  beq $0, $0, nextelm

notD:
  ; Check F
  addi $8, $0, 70         ; ASCII 'F' 
  sw $8, 0($6)

nextelm:
  addi $14, $14, 4        
  addi $12, $12, 1        
  beq $0, $0, gradelp

donegrade:
  sw $7, 0($6)            
  jr $31

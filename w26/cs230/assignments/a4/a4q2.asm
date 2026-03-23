; a4q2.asm
;
; Name: Talha Yildirim
; Quest ID: 21014743
;
; Description: Reads a line of text from standard input, then prints the
;   substring from index $1 (inclusive) to index $2 (exclusive), followed
;   by a newline. If the indices are out of range, prints nothing and sets
;   $3 = 1. Otherwise sets $3 = 0.
;
; Register usage:
; $1  - start index of substring
; $2  - end index of substring, exclusive
; $3  - output flag: 0 = valid/success, 1 = invalid indices
; $5  - stdin address  (0xffff0004)
; $6  - stdout address (0xffff000c)
; $7  - newline constant (10 = 0xA)
; $8  - temporary: current byte read or current character to print
; $9  - string length
; $10 - current index during the print loop
; $11 - base address of the string buffer (bottom of allocated stack space)
; $12 - current memory address (write pointer during read, read pointer during print)
; $30 - stack pointer (decremented to allocate buffer, fully restored before jr $31)

; Intialize constants
lis $5
.word 0xffff0004          ; stdin

lis $6
.word 0xffff000c          ; stdout

addi $7, $0, 10           ; newline = ASCII 0xA

; Allocate string buffer on the stack
; Each character is stored as one word (4 bytes) because binasm only has lw/sw.
; 1024 words = 4096 bytes is a safe upper bound for a line of keyboard input.
addi $8, $0, 4096

; grow stack downward by 4096 bytes
sub $30, $30, $8

add $11, $30, $0

; Read string from stdin into buffer
add $9, $0, $0            ; $9 = length = 0
add $12, $11, $0

readstr:
  lw $8, 0($5)
  beq $8, $7, doneread
  sw $8, 0($12)
  addi $12, $12, 4
  addi $9, $9, 1        ; increment string length
  beq $0, $0, readstr

doneread:

; Validate indicdes 
; Check $1 >= 0
  slt $8, $1, $0      
  bne $8, $0, invalid

; Check $1 < length
  slt $8, $1, $9       
  beq $8, $0, invalid   

; Check $2 >= $1
  slt $8, $2, $1         
  bne $8, $0, invalid

; Check $2 <= length
  slt $8, $9, $2          
  bne $8, $0, invalid

; print substring
; Compute address of first character: $11 + $1 * 4
addi $8, $0, 4
mult $1, $8
mflo $12
add $12, $12, $11

add $10, $1, $0           ; $10 = current index, starts at $1

; stop when current index reaches $2
printlp:
  beq $10, $2, doneprt
  lw $8, 0($12)
  sw $8, 0($6)
  addi $12, $12, 4
  addi $10, $10, 1
  beq $0, $0, printlp

doneprt:
  ; print newline after substring
  sw $7, 0($6)
  add $3, $0, $0   
  beq $0, $0, cleanup

invalid:
  addi $3, $0, 1  

; retore and return
cleanup:
lis $8
.word 4096
add $30, $30, $8
jr $31

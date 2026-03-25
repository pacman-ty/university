# CS 230 Assignment 5 - Question 2

## The Program

```asm
        addi $3, $0, 4          ; 0: $3 = 4
        mult $3, $2             ; 1: hi:lo = 4 * $2
        mflo $3                 ; 2: $3 = lo (= 4 * array_size)
        add $15, $1, $3         ; 3: $15 = addr of one-past-end of array
        addi $15, $15, -4       ; 4: $15 = addr of last element
        add $3, $0, $0          ; 5: $3 = 0 (accumulator)
loop:   lw $5, -4($15)          ; 6: $5 = element before current
        lw $6, 0($15)           ; 7: $6 = current element
        sub $7, $5, $6          ; 8: $7 = prev - current
        slt $8, $7, $0          ; 9: $8 = 1 if $7 < 0
        beq $8, $0, endif       ; 10: if $7 >= 0, skip negation
        sub $7, $0, $7          ; 11: $7 = -$7 (absolute value)
endif:  add $3, $3, $7          ; 12: accumulate |difference|
        addi $15, $15, -4       ; 13: move pointer left
        bne $15, $1, loop       ; 14: loop if not at start
        jr $31                  ; 15: return
```

This program computes the sum of absolute differences between adjacent elements, traversing the array from right to left. The result is stored in `$3`.

---

## Part (a): Machine Code (Hex)

Each instruction is encoded using the MIPS reference sheet formats.

### Instruction-by-instruction encoding

**Instruction 0: `addi $3, $0, 4`** (I-format)

- Opcode for addi: `001000`
- s = $0 = `00000`, t = $3 = `00011`, i = 4 = `0000 0000 0000 0100`
- Binary: `0010 0000 0000 0011 0000 0000 0000 0100`
- Hex: **0x20030004**

**Instruction 1: `mult $3, $2`** (R-format)

- Opcode: `000000`
- s = $3 = `00011`, t = $2 = `00010`, rest = `0000 0000 0001 1000`
- Binary: `0000 0000 0110 0010 0000 0000 0001 1000`
- Hex: **0x00620018**

**Instruction 2: `mflo $3`** (R-format)

- Opcode: `000000`, s = 0, t = 0, d = $3 = `00011`, func = `010010`
- Binary: `0000 0000 0000 0000 0001 1000 0001 0010`
- Hex: **0x00001812**

**Instruction 3: `add $15, $1, $3`** (R-format)

- s = $1 = `00001`, t = $3 = `00011`, d = $15 = `01111`, func = `100000`
- Binary: `0000 0000 0010 0011 0111 1000 0010 0000`
- Hex: **0x00237820**

**Instruction 4: `addi $15, $15, -4`** (I-format)

- s = $15 = `01111`, t = $15 = `01111`, i = -4 = `1111 1111 1111 1100`
- Binary: `0010 0001 1110 1111 1111 1111 1111 1100`
- Hex: **0x21EFFFFC**

**Instruction 5: `add $3, $0, $0`** (R-format)

- s = $0 = `00000`, t = $0 = `00000`, d = $3 = `00011`, func = `100000`
- Binary: `0000 0000 0000 0000 0001 1000 0010 0000`
- Hex: **0x00001820**

**Instruction 6: `lw $5, -4($15)`** (I-format)

- Opcode for lw: `100011`
- s = $15 = `01111`, t = $5 = `00101`, i = -4 = `1111 1111 1111 1100`
- Binary: `1000 1101 1110 0101 1111 1111 1111 1100`
- Hex: **0x8DE5FFFC**

**Instruction 7: `lw $6, 0($15)`** (I-format)

- s = $15 = `01111`, t = $6 = `00110`, i = 0
- Binary: `1000 1101 1110 0110 0000 0000 0000 0000`
- Hex: **0x8DE60000**

**Instruction 8: `sub $7, $5, $6`** (R-format)

- s = $5 = `00101`, t = $6 = `00110`, d = $7 = `00111`, func = `100010`
- Binary: `0000 0000 1010 0110 0011 1000 0010 0010`
- Hex: **0x00A63822**

**Instruction 9: `slt $8, $7, $0`** (R-format)

- s = $7 = `00111`, t = $0 = `00000`, d = $8 = `01000`, func = `101010`
- Binary: `0000 0000 1110 0000 0100 0000 0010 1010`
- Hex: **0x00E0402A**

**Instruction 10: `beq $8, $0, endif`** (I-format)

- Opcode for beq: `000100`
- s = $8 = `01000`, t = $0 = `00000`
- beq is at address 0x28. After fetch, PC = 0x2C. `endif` is at address 0x30.
- Offset = (0x30 - 0x2C) / 4 = **1**
- Binary: `0001 0001 0000 0000 0000 0000 0000 0001`
- Hex: **0x11000001**

**Instruction 11: `sub $7, $0, $7`** (R-format)

- s = $0 = `00000`, t = $7 = `00111`, d = $7 = `00111`, func = `100010`
- Binary: `0000 0000 0000 0111 0011 1000 0010 0010`
- Hex: **0x00073822**

**Instruction 12: `add $3, $3, $7`** (R-format, `endif` label)

- s = $3 = `00011`, t = $7 = `00111`, d = $3 = `00011`, func = `100000`
- Binary: `0000 0000 0110 0111 0001 1000 0010 0000`
- Hex: **0x00671820**

**Instruction 13: `addi $15, $15, -4`** (I-format)

- Same encoding as instruction 4
- Hex: **0x21EFFFFC**

**Instruction 14: `bne $15, $1, loop`** (I-format)

- Opcode for bne: `000101`
- s = $15 = `01111`, t = $1 = `00001`
- bne is at address 0x38. After fetch, PC = 0x3C. `loop` is at address 0x18.
- Offset = (0x18 - 0x3C) / 4 = -0x24 / 4 = **-9**
- -9 in 16-bit two's complement: `1111 1111 1111 0111` = 0xFFF7
- Binary: `0001 0101 1110 0001 1111 1111 1111 0111`
- Hex: **0x15E1FFF7**

**Instruction 15: `jr $31`** (R-format)

- s = $31 = `11111`, func = `001000`
- Binary: `0000 0011 1110 0000 0000 0000 0000 1000`
- Hex: **0x03E00008**

### Final Machine Code (a5q2a.txt)

```
0x20030004
0x00620018
0x00001812
0x00237820
0x21EFFFFC
0x00001820
0x8DE5FFFC
0x8DE60000
0x00A63822
0x00E0402A
0x11000001
0x00073822
0x00671820
0x21EFFFFC
0x15E1FFF7
0x03E00008
```

---

## Part (b): CPI and CPU Time

### Step 1: Trace the execution with array [2, 8, 7, 12], size = 4

The array in memory (starting at address `$1`):

| Address  | Value |
|----------|-------|
| $1 + 0   | 2     |
| $1 + 4   | 8     |
| $1 + 8   | 7     |
| $1 + 12  | 12    |

**Pre-loop setup:**

| # | Instruction         | Effect                              |
|---|---------------------|-------------------------------------|
| 0 | addi $3, $0, 4      | $3 = 4                              |
| 1 | mult $3, $2         | hi:lo = 4 * 4 = 16                  |
| 2 | mflo $3             | $3 = 16                             |
| 3 | add $15, $1, $3     | $15 = $1 + 16                       |
| 4 | addi $15, $15, -4   | $15 = $1 + 12 (points to arr[3]=12) |
| 5 | add $3, $0, $0      | $3 = 0 (accumulator reset)          |

**Loop Iteration 1** ($15 = $1+12):

| # | Instruction         | Effect                                     |
|---|---------------------|--------------------------------------------|
| 6 | lw $5, -4($15)      | $5 = MEM[$1+8] = 7                         |
| 7 | lw $6, 0($15)       | $6 = MEM[$1+12] = 12                       |
| 8 | sub $7, $5, $6      | $7 = 7 - 12 = -5                           |
| 9 | slt $8, $7, $0      | $8 = 1 (since -5 < 0)                      |
| 10| beq $8, $0, endif   | $8 != 0, **NOT taken** (fall through)       |
| 11| sub $7, $0, $7      | $7 = -(-5) = 5                              |
| 12| add $3, $3, $7      | $3 = 0 + 5 = 5                              |
| 13| addi $15, $15, -4   | $15 = $1 + 8                                |
| 14| bne $15, $1, loop   | $1+8 != $1, **TAKEN** → go to loop          |

**Loop Iteration 2** ($15 = $1+8):

| # | Instruction         | Effect                                     |
|---|---------------------|--------------------------------------------|
| 6 | lw $5, -4($15)      | $5 = MEM[$1+4] = 8                         |
| 7 | lw $6, 0($15)       | $6 = MEM[$1+8] = 7                         |
| 8 | sub $7, $5, $6      | $7 = 8 - 7 = 1                             |
| 9 | slt $8, $7, $0      | $8 = 0 (since 1 >= 0)                      |
| 10| beq $8, $0, endif   | $8 = 0, **TAKEN** → skip to endif           |
| 12| add $3, $3, $7      | $3 = 5 + 1 = 6                              |
| 13| addi $15, $15, -4   | $15 = $1 + 4                                |
| 14| bne $15, $1, loop   | $1+4 != $1, **TAKEN** → go to loop          |

**Loop Iteration 3** ($15 = $1+4):

| # | Instruction         | Effect                                     |
|---|---------------------|--------------------------------------------|
| 6 | lw $5, -4($15)      | $5 = MEM[$1+0] = 2                         |
| 7 | lw $6, 0($15)       | $6 = MEM[$1+4] = 8                         |
| 8 | sub $7, $5, $6      | $7 = 2 - 8 = -6                            |
| 9 | slt $8, $7, $0      | $8 = 1 (since -6 < 0)                      |
| 10| beq $8, $0, endif   | $8 != 0, **NOT taken**                      |
| 11| sub $7, $0, $7      | $7 = -(-6) = 6                              |
| 12| add $3, $3, $7      | $3 = 6 + 6 = 12                             |
| 13| addi $15, $15, -4   | $15 = $1                                    |
| 14| bne $15, $1, loop   | $1 = $1, **NOT TAKEN** → exit loop          |

**Post-loop:**

| # | Instruction | Effect    |
|---|-------------|-----------|
| 15| jr $31      | return    |

Final result: $3 = **12** (sum of absolute differences: |7-12| + |8-7| + |2-8| = 5 + 1 + 6 = 12)

### Step 2: Count instructions by category

**Memory accesses (lw/sw) — 8 cycles each:**

- Each iteration has 2 lw instructions
- 3 iterations × 2 = **6 memory instructions**

**Branch/Jump instructions (beq, bne, jr) — 1 cycle each:**

- Each iteration: 1 beq + 1 bne = 2 branch instructions
- 3 iterations × 2 = 6 branch instructions
- Plus 1 jr at the end
- Total: **7 branch/jump instructions**

**Everything else — 5 cycles each:**

- Pre-loop: addi, mult, mflo, add, addi, add = **6 instructions**
- Iteration 1: sub, slt, sub, add, addi = **5 instructions** (beq not taken → sub executes)
- Iteration 2: sub, slt, add, addi = **4 instructions** (beq taken → sub skipped)
- Iteration 3: sub, slt, sub, add, addi = **5 instructions** (beq not taken → sub executes)
- Total: 6 + 5 + 4 + 5 = **20 "other" instructions**

**Verification:** 6 + 7 + 20 = **33 total instructions**

### Step 3: Calculate total cycles

| Category         | Count | Cycles/Instr | Total Cycles |
|------------------|-------|--------------|--------------|
| Memory (lw)      | 6     | 8            | 48           |
| Branch/Jump      | 7     | 1            | 7            |
| Everything else  | 20    | 5            | 100          |
| **Total**        | **33**|              | **155**      |

### Step 4: Calculate CPI

$$\text{CPI} = \frac{\text{Total Cycles}}{\text{Total Instructions}} = \frac{155}{33} \approx 4.70$$

### Step 5: Calculate CPU Time

$$\text{CPU Time} = \frac{\text{Total Cycles}}{\text{Clock Rate}} = \frac{155}{8 \times 10^9 \text{ Hz}} = 19.375 \times 10^{-9} \text{ s} = 19.375 \text{ ns}$$

### Summary

- **CPI = 155/33 ≈ 4.70**
- **CPU Time = 19.375 ns**

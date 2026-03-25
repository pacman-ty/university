### Hazards

**1. Lines 1 --> 3: Register $9**

- Line 1 (`add $9, $0, $1`) writes `$9` in WB.
- Line 3 (`lw $4, 0($9)`) reads `$9` in ID.
- There is only **one instruction** between them (line 2), so line 1 is in MEM when line 3 is in ID. Line 3 tries to read `$9` before line 1 writes it back.

**2. Lines 3 --> 4: Register $4 (Load-Use Hazard)**

- Line 3 (`lw $4, 0($9)`) writes `$4`. Because this is a **load word**, the value isn't available until after the MEM stage (one stage later than ALU instructions).
- Line 4 (`slt $5, $4, $0`) reads `$4` in ID.
- They are **adjacent** instructions. Line 4 needs `$4` in ID, but line 3 won't have the loaded value until after MEM.

**3. Lines 4 --> 5: Register $5**

- Line 4 (`slt $5, $4, $0`) writes `$5` in WB.
- Line 5 (`beq $5, $0, endif`) reads `$5` in ID.
- They are **adjacent**. Line 5 tries to read `$5` before line 4 writes it.

**4. Lines 6 --> 7: Register $4**

- Line 6 (`sub $4, $0, $4`) writes `$4` in WB.
- Line 7 (`sw $4, 0($9)`) reads `$4` in ID.
- They are **adjacent**. Line 7 tries to read `$4` before line 6 writes it.

**5. Lines 9 --> 10: Register $8**

- Line 9 (`addi $8, $8, 1`) writes `$8` in WB.
- Line 10 (`bne $8, $2, loop`) reads `$8` in ID.
- They are **adjacent** (distance 1). Line 10 tries to read `$8` before line 9 writes it.

### Control Hazards

**6. Line 5: `beq $5, $0, endif`**

- This is a conditional branch. The processor does not know whether to fetch line 6 or line 8 until the branch condition is evaluated.
- **Control hazard** — the outcome of the branch is not resolved until the EX or MEM stage (depending on implementation), so the pipeline may fetch incorrect instructions.

**7. Line 10: `bne $8, $2, loop`**

- This is a conditional branch. The processor does not know whether to fetch line 11 or line 3 until the branch is resolved.

**8. Line 11: `jr $31`**

- This is a jump register instruction. The target address is stored in `$31`, and it must be read from the register file before the jump target is known.


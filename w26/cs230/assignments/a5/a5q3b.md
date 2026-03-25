### Execution Trace

Array = [-2, 5], size = 2. $1 = address of first element, $2 = 2.

**Iteration 1** (element = -2):

| Line | Instruction | Effect |
|------|------------|--------|
| 1 | add $9, $0, $1 | $9 = $1 (pointer to array) |
| 2 | add $8, $0, $0 | $8 = 0 (counter) |
| 3 | lw $4, 0($9) | $4 = MEM[$1] = -2 |
| 4 | slt $5, $4, $0 | $5 = 1 (since -2 < 0) |
| 5 | beq $5, $0, endif | 1 ≠ 0 --> **NOT taken** |
| 6 | sub $4, $0, $4 | $4 = 0-(-2) = 2 |
| 7 | sw $4, 0($9) | MEM[$1] = 2 |
| 8 | addi $9, $9, 4 | $9 = $1+4 |
| 9 | addi $8, $8, 1 | $8 = 1 |
| 10 | bne $8, $2, loop | 1 ≠ 2 --> **TAKEN** |

**Iteration 2** (element = 5):

| Line | Instruction | Effect |
|------|------------|--------|
| 3 | lw $4, 0($9) | $4 = MEM[$1+4] = 5 |
| 4 | slt $5, $4, $0 | $5 = 0 (since 5 ≥ 0) |
| 5 | beq $5, $0, endif | 0 = 0 --> **TAKEN** |
| 8 | addi $9, $9, 4 | $9 = $1+8 |
| 9 | addi $8, $8, 1 | $8 = 2 |
| 10 | bne $8, $2, loop | 2 = 2 --> **NOT taken** |
| 11 | jr $31 | return |

**Total instructions executed: 17**

### Pipeline Hazard Analysis

Without any pipeline optimizations (no forwarding, no branch prediction):

- **Data hazards**: a dependent instruction stalls until the producing instruction completes WB.
  - Adjacent instructions (distance 1): 2 stalls needed
  - Distance 2 instructions: 1 stall needed
  - Distance 3+: no stall (WB/ID same cycle, write-first/read-second)
- **Control hazards**: the pipeline stalls after every branch/jump until the outcome is resolved at the end of EX - 2 stalls per branch/jump.

### Hazards in execution order

| # | Hazard | Type | Stalls |
|---|--------|------|--------|
| D1 | L1→L3: $9 | Data | 1 |
| D2 | L3→L4: $4, load-use | Data | 2 |
| D3 | L4→L5: $5 | Data | 2 |
| C1 | L5: beq | Control | 2 |
| D4 | L6→L7: $4 | Data | 2 |
| D5 | L9→L10: $8 | Data | 2|
| C2 | L10: bne | Control | 2 |
| D6 | L3→L4: $4, load-use [iter 2] | Data | 2 |
| D7 | L4→L5: $5 [iter 2] | Data | 2 |
| C3 | L5: beq  | Control | 2 |
| D8 | L9→L10: $8  [iter 2] | Data | 2 |
| C4 | L10: bne | Control | 2 |

**Total: 15 data stalls + 8 control stalls = 23 stall bubbles**

### Pipeline Diagram

Each stall bubble is shown as a row that passes through all 5 pipeline stages. The dependent instruction follows after the last stall bubble.

| Row | Instruction / Event | IF | ID | EX | MEM | WB |
|----:|---------------------|---:|---:|---:|----:|---:|
| 1 | L1: add $9,$0,$1 | 1 | 2 | 3 | 4 | 5 |
| 2 | L2: add $8,$0,$0 | 2 | 3 | 4 | 5 | 6 |
| 3 | stall D1 (data $9, L1 --> L3) | 3 | 4 | 5 | 6 | 7 |
| 4 | **L3: lw $4,0($9)** | 4 | 5 | 6 | 7 | 8 |
| 5 | stall D2a (data $4, L3 --> L4) | 5 | 6 | 7 | 8 | 9 |
| 6 | stall D2b (data $4, L3 --> L4) | 6 | 7 | 8 | 9 | 10 |
| 7 | **L4: slt $5,$4,$0** | 7 | 8 | 9 | 10 | 11 |
| 8 | stall D3a (data $5, L4 --> L5) | 8 | 9 | 10 | 11 | 12 |
| 9 | stall D3b (data $5, L4 --> L5) | 9 | 10 | 11 | 12 | 13 |
| 10 | **L5: beq $5,$0,endif** (NOT taken) | 10 | 11 | 12 | 13 | 14 |
| 11 | stall C1a (control, beq) | 11 | 12 | 13 | 14 | 15 |
| 12 | stall C1b (control, beq) | 12 | 13 | 14 | 15 | 16 |
| 13 | L6: sub $4,$0,$4 | 13 | 14 | 15 | 16 | 17 |
| 14 | stall D4a (data $4, L6 --> L7) | 14 | 15 | 16 | 17 | 18 |
| 15 | stall D4b (data $4, L6 --> L7) | 15 | 16 | 17 | 18 | 19 |
| 16 | **L7: sw $4,0($9)** | 16 | 17 | 18 | 19 | 20 |
| 17 | L8: addi $9,$9,4 | 17 | 18 | 19 | 20 | 21 |
| 18 | L9: addi $8,$8,1 | 18 | 19 | 20 | 21 | 22 |
| 19 | stall D5a (data $8, L9 --> L10) | 19 | 20 | 21 | 22 | 23 |
| 20 | stall D5b (data $8, L9 --> L10) | 20 | 21 | 22 | 23 | 24 |
| 21 | **L10: bne $8,$2,loop** (TAKEN) | 21 | 22 | 23 | 24 | 25 |
| 22 | stall C2a (control, bne) | 22 | 23 | 24 | 25 | 26 |
| 23 | stall C2b (control, bne) | 23 | 24 | 25 | 26 | 27 |
| 24 | **L3: lw $4,0($9)** [iter 2] | 24 | 25 | 26 | 27 | 28 |
| 25 | stall D6a (data $4, L3 --> L4) | 25 | 26 | 27 | 28 | 29 |
| 26 | stall D6b (data $4, L3 --> L4) | 26 | 27 | 28 | 29 | 30 |
| 27 | **L4: slt $5,$4,$0** [iter 2] | 27 | 28 | 29 | 30 | 31 |
| 28 | stall D7a (data $5, L4 --> L5) | 28 | 29 | 30 | 31 | 32 |
| 29 | stall D7b (data $5, L4 --> L5) | 29 | 30 | 31 | 32 | 33 |
| 30 | **L5: beq $5,$0,endif** (TAKEN) [iter 2] | 30 | 31 | 32 | 33 | 34 |
| 31 | stall C3a (control, beq) | 31 | 32 | 33 | 34 | 35 |
| 32 | stall C3b (control, beq) | 32 | 33 | 34 | 35 | 36 |
| 33 | L8: addi $9,$9,4 [iter 2] | 33 | 34 | 35 | 36 | 37 |
| 34 | L9: addi $8,$8,1 [iter 2] | 34 | 35 | 36 | 37 | 38 |
| 35 | stall D8a (data $8, L9→L10) | 35 | 36 | 37 | 38 | 39 |
| 36 | stall D8b (data $8, L9→L10) | 36 | 37 | 38 | 39 | 40 |
| 37 | **L10: bne $8,$2,loop** (NOT taken) [iter 2] | 37 | 38 | 39 | 40 | 41 |
| 38 | stall C4a (control, bne) | 38 | 39 | 40 | 41 | 42 |
| 39 | stall C4b (control, bne) | 39 | 40 | 41 | 42 | 43 |
| 40 | **L11: jr $31** | 40 | 41 | 42 | 43 | 44 |

### Total Cycle Count

$$\text{Cycles} = \text{Instructions} + (\text{Pipeline depth} - 1) + \text{Stalls} = 17 + 4 + 23 = \boxed{44 \text{ cycles}}$$

---

## Part (c): Forwarding + Static Branch Prediction

### Effect of Forwarding

With forwarding, ALU results are available at the end of EX (bypassing the register file). Load results are available at the end of MEM. This reduces or eliminates data hazard stalls:

| Original Hazard | Without Forwarding | With Forwarding | Reason |
|---|---|---|---|
| ALU→use, distance 1 | 2 stalls | **0 stalls** | EX output forwarded to next EX input |
| ALU→use, distance 2 | 1 stall | **0 stalls** | EX/MEM output forwarded |
| Load→use, distance 1 | 2 stalls | **1 stall** | MEM output not ready until end of MEM; EX of dependent instruction needs it at start of same cycle — must wait 1 cycle |

### Stall rows eliminated by forwarding (13 saved)

| Row | Original Stall | Why Eliminated |
|-----|---------------|----------------|
| 3 | D1: data $9, L1→L3 (distance 2) | ALU result forwarded from MEM/WB to EX |
| 6 | D2b: data $4, L3→L4 (1 of 2) | Load-use reduced from 2 stalls to 1 (row 5 remains) |
| 8 | D3a: data $5, L4→L5 | ALU result forwarded from EX/MEM to EX |
| 9 | D3b: data $5, L4→L5 | ALU result forwarded from EX/MEM to EX |
| 14 | D4a: data $4, L6→L7 | ALU result forwarded from EX/MEM to MEM (for sw) |
| 15 | D4b: data $4, L6→L7 | ALU result forwarded from EX/MEM to MEM |
| 19 | D5a: data $8, L9→L10 | ALU result forwarded from EX/MEM to EX |
| 20 | D5b: data $8, L9→L10 | ALU result forwarded from EX/MEM to EX |
| 26 | D6b: data $4, L3→L4 iter 2 (1 of 2) | Load-use reduced from 2 to 1 (row 25 remains) |
| 28 | D7a: data $5, L4→L5 iter 2 | ALU forwarded |
| 29 | D7b: data $5, L4→L5 iter 2 | ALU forwarded |
| 35 | D8a: data $8, L9→L10 iter 2 | ALU forwarded |
| 36 | D8b: data $8, L9→L10 iter 2 | ALU forwarded |

**Forwarding saves 13 stall cycles.** Two load-use stalls remain (rows 5 and 25).

### Effect of Static Branch Prediction (Predict Not Taken)

With static branch prediction, the pipeline predicts all branches as **not taken** and speculatively fetches the next sequential instruction:

- If the prediction is **correct** (branch not taken): **0 stall cycles** — the fetched instruction is correct.
- If the prediction is **wrong** (branch taken): **2 stall cycles** — the incorrectly fetched instructions must be flushed (same penalty as stalling without prediction).

| Branch | Predicted | Actual | Correct? | Stalls |
|--------|-----------|--------|----------|--------|
| L5 beq, iter 1 | Not taken | Not taken | Yes | 0 |
| L10 bne, iter 1 | Not taken | Taken | No | 2 |
| L5 beq, iter 2 | Not taken | Taken | No | 2 |
| L10 bne, iter 2 | Not taken | Not taken | Yes | 0 |

### Stall rows eliminated by branch prediction (4 saved)

| Row | Original Stall | Why Eliminated |
|-----|---------------|----------------|
| 11 | C1a: control, beq iter 1 | Correctly predicted not taken |
| 12 | C1b: control, beq iter 1 | Correctly predicted not taken |
| 38 | C4a: control, bne iter 2 | Correctly predicted not taken |
| 39 | C4b: control, bne iter 2 | Correctly predicted not taken |

Rows 22, 23 (bne iter 1 TAKEN) and 31, 32 (beq iter 2 TAKEN) are **not eliminated** — these are mispredictions that still incur 2-cycle flush penalties.

**Branch prediction saves 4 stall cycles.**

### Summary

| Source | Stalls Saved |
|--------|-------------|
| Forwarding | 13 |
| Static branch prediction | 4 |
| **Total saved** | **17** |

$$\text{New cycle count} = 44 - 17 = \boxed{27 \text{ cycles}}$$

**Stalls remaining (6):** 2 load-use stalls (rows 5, 25) + 4 misprediction stalls (rows 22, 23, 31, 32).

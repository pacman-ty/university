### Effect of Forwarding

With forwarding, ALU results are available at the end of EX (bypassing the register file). Load results are available at the end of MEM. This reduces or eliminates data hazard stalls:

| Original Hazard | Without Forwarding | With Forwarding | Reason |
|---|---|---|---|
| ALU --> use, distance 1 | 2 stalls | **0 stalls** | EX output forwarded to next EX input |
| ALU --> use, distance 2 | 1 stall | **0 stalls** | EX/MEM output forwarded |
| Load --> use, distance 1 | 2 stalls | **1 stall** | MEM output not ready until end of MEM; EX of dependent instruction needs it at start of same cycle — must wait 1 cycle |

### Stall rows eliminated by forwarding (13 saved)

| Row | Original Stall | Why Eliminated |
|-----|---------------|----------------|
| 3 | D1: data $9, L1 --> L3 (distance 2) | ALU result forwarded from MEM/WB to EX |
| 6 | D2b: data $4, L3 --> L4 (1 of 2) | Load-use reduced from 2 stalls to 1 (row 5 remains) |
| 8 | D3a: data $5, L4 --> L5 | ALU result forwarded from EX/MEM to EX |
| 9 | D3b: data $5, L4 --> L5 | ALU result forwarded from EX/MEM to EX |
| 14 | D4a: data $4, L6 --> L7 | ALU result forwarded from EX/MEM to MEM (for sw) |
| 15 | D4b: data $4, L6 --> L7 | ALU result forwarded from EX/MEM to MEM |
| 19 | D5a: data $8, L9 --> L10 | ALU result forwarded from EX/MEM to EX |
| 20 | D5b: data $8, L9 --> L10 | ALU result forwarded from EX/MEM to EX |
| 26 | D6b: data $4, L3 --> L4 iter 2 (1 of 2) | Load-use reduced from 2 to 1 (row 25 remains) |
| 28 | D7a: data $5, L4 --> L5 iter 2 | ALU forwarded |
| 29 | D7b: data $5, L4 --> L5 iter 2 | ALU forwarded |
| 35 | D8a: data $8, L9 --> L10 iter 2 | ALU forwarded |
| 36 | D8b: data $8, L9 --> L10 iter 2 | ALU forwarded |

**Forwarding saves 13 stall cycles.** Two load-use stalls remain (rows 5 and 25).

### Effect of Static Branch Prediction (Predict Not Taken)

With static branch prediction, the pipeline predicts all branches as not taken and speculatively fetches the next sequential instruction:

- If the prediction is correct (branch not taken): 0 stall cycles — the fetched instruction is correct.
- If the prediction is wrong (branch taken): 2 stall cycles — the incorrectly fetched instructions must be flushed (same penalty as stalling without prediction).

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

Rows 22, 23 (bne iter 1 TAKEN) and 31, 32 (beq iter 2 TAKEN) are not eliminated — these are mispredictions that still incur 2-cycle flush penalties.

Branch prediction saves 4 stall cycles.

### Summary

| Source | Stalls Saved |
|--------|-------------|
| Forwarding | 13 |
| Static branch prediction | 4 |
| **Total saved** | **17** |

$$\text{New cycle count} = 44 - 17 = \boxed{27 \text{ cycles}}$$

**Stalls remaining (6):** 2 load-use stalls (rows 5, 25) + 4 misprediction stalls (rows 22, 23, 31, 32).

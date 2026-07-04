# Changes Made to CPU-Verilog Codebase

## a. Module/Filename Inconsistencies Fixed

| File | Issue | Fix |
|------|-------|-----|
| `alu.sv` | Module was named `cu` (copy-paste error) | Renamed module to `alu` |
| `cu.sv` | Empty module stub; real CU logic was in `alu.sv` | Replaced with complete CU implementation |
| `pc.sv` | `pc_reg` declared twice — in port list and as internal `logic` | Removed duplicate declaration |
| `top.sv` | Instantiated `instruction_memory` but module is `instruction_mem` | Fixed instantiation to use correct module name |
| `top.sv` | `alu_ctrl` was 3 bits but ALU needs 4 bits | Changed `alu_ctrl` to `[3:0]` |
| `instruction_mem.sv` | Filename `instruction_mem.sv` — module kept as `instruction_mem` (consistent with filename) | No rename needed; top.sv fixed instead |

## b. Instruction Set Completion (RV32I, no branches)

### ALU (`alu.sv`)
- Replaced stub with full 10-operation ALU
- **alu_ctrl encoding**: 0000=add, 0001=sub, 0010=sll, 0011=slt, 0100=sltu, 0101=xor, 0110=srl, 0111=sra, 1000=or, 1001=and

### Control Unit (`cu.sv`)
- **R-type** (opcode 0110011): decodes funct3 + funct7[5] for all 10 operations
- **I-type arithmetic** (opcode 0010011): decodes funct3 for addi, slli, slti, sltiu, xori, srli/srai, ori, andi
- **Load** (opcode 0000011): generates mem_read, alu_src, mem_to_reg signals
- **Store** (opcode 0100011): generates mem_write, alu_src signals

### Data Memory (`memory.sv`)
- Added `funct3` input and changed `addr` from `[2:0]` (word index) to `[31:0]` (full byte address)
- Load (funct3): 000=lb(sign-ext), 001=lh(sign-ext), 010=lw, 100=lbu(zero-ext), 101=lhu(zero-ext)
- Store (funct3): 000=sb, 001=sh, 010=sw
- Read-modify-write for partial stores (sb, sh)

### Top (`top.sv`)
- Wired `funct3` from instruction fields to memory module
- Changed memory `addr` from `alu_result[4:2]` to full `alu_result`

### Immediate Generator (`imm_gen.sv`)
- Simplified case statement with grouped I-type cases (I-type arithmetic + Load both use same format)
- Handles I-type, S-type, and R-type (zero output)

## c. Comment Cleanup

- Removed all Xilinx Vivado template headers (company, engineer, date, revision, etc.)
- Added a one-line short intro comment at the top of each `.sv` module describing its purpose
- `program.mem`: added instruction comments

## d. New Files

### `tb_CU.sv`
- Testbench that instantiates `top`, generates clock (period 10ns), applies reset, runs 8+ cycles
- Tests 6 instructions: `addi`, `addi`, `add`, `sub`, `sw`, `lw`
- Displays register values (x1–x5) and memory location mem[0] with expected values
- Prints PASS/FAIL summary

### `program.mem`
- Contains the test program (hex values only, no comments for simulator compatibility):
  - `00500093` → addi x1, x0, 5
  - `00A00113` → addi x2, x0, 10
  - `002081B3` → add x3, x1, x2
  - `40218233` → sub x4, x3, x1
  - `00402023` → sw x4, 0(x0)
  - `00002283` → lw x5, 0(x0)
  - `00000013` → nop (×2)

## Simulation Notes

- `program.mem` must be in the simulator's working directory, or update the path in `instruction_mem.sv:12` and `tb_CU.sv:17`
- Expected results: x1=5, x2=10, x3=15, x4=10, x5=10, mem[0]=10
- All tests PASS if all values match expected

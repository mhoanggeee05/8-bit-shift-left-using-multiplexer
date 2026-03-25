# Registered Shift Unit (A << B)

## Overview
8-bit left shift unit implemented in SystemVerilog with registered inputs and outputs. 
Shift operation is built structurally using multiplexers (no shift operator).

## Features
- Variable left shift (A << B[2:0])
- Input registers with enable (ENA, ENB)
- Structural shifter using 8:1 MUX
- Registered output (synchronous design)

## Structure
- `shiftreg`: MUX-based shifter
- `MUX`: 8-to-1 multiplexer (gate-level)
- `nbitregEA/EB`: registers with enable
- `nbitreg`: output register

## Notes
- Shift amount limited to 0–7 bits
- Output is zero when shift exceeds range
- Verified using simulation

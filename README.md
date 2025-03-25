# Frequency Divider in Verilog

## Overview
This repository contains a Verilog implementation of a **Frequency Divider** using **D flip-flops**. The module divides the input clock frequency by a factor of `N` (parameterized).

## Features
- Supports parameterized frequency division.
- Uses `clogb2` function to compute required flip-flops.
- Designed for FPGA implementation.

## Files
- `freqDivider.v` - The Verilog implementation of the frequency divider.
- `freqDivider_Tb.v` - Testbench to simulate the frequency divider.

## Usage
### Running the Testbench
To simulate the design using **ModelSim**, **Vivado**, or **iverilog**:
```bash
iverilog -o freqDivider_tb freqDivider_tb.v freqDivider.v
vvp freqDivider_tb
gtkwave freqDivider.vcd

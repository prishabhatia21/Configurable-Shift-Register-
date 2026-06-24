# Configurable Shift Register in SystemVerilog

A parameterized configurable shift register supporting four modes of operation 
and both shift directions, implemented in SystemVerilog.

---

## Features
- Parameterized width (default 8-bit)
- 4 operation modes: SISO, SIPO, PISO, PIPO
- Left and right shift direction control
- Synchronous parallel load
- Active high asynchronous reset

---

## Port Description

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| clk | Input | 1 | Clock signal. All inputs sampled at posedge |
| reset | Input | 1 | Active high async reset. Clears register to 0 |
| load | Input | 1 | When high, loads data_in into register in one cycle |
| mode | Input | 2 | Operation mode selector |
| shift_dir | Input | 1 | 0 = Left shift, 1 = Right shift |
| serial_in | Input | 1 | Serial input bit for SISO and SIPO modes |
| data_in | Input | 8 | Parallel input, loaded when load=1 |
| serial_out | Output | 1 | Serial output bit for SISO and PISO modes |
| data_out | Output | 8 | Parallel output, holds current register value |

---

## Modes

| mode[1:0] | Mode | Data In | Data Out | Use Case |
|-----------|------|---------|----------|----------|
| 00 | SISO | 1 bit/cycle via serial_in | 1 bit/cycle via serial_out | Serial communication |
| 01 | SIPO | 1 bit/cycle via serial_in | All 8 bits via data_out | Deserializer |
| 10 | PISO | 8 bits loaded via load | 1 bit/cycle via serial_out | Serializer |
| 11 | PIPO | 8 bits loaded via load | All 8 bits via data_out | Parallel register |

---

## How to Run

1. Open [EDA Playground](https://edaplayground.com)
2. Paste `shift_register.sv` in the design editor
3. Select **Cadence Xcelium** as the simulator
4. Add testbench and run

---

## Tools Used
- SystemVerilog
- Cadence Xcelium (via EDA Playground)

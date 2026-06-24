# Configurable Shift Register in SystemVerilog

A fully parameterized, synthesizable shift register implemented in SystemVerilog,  
supporting all four classic modes of operation with bidirectional shifting,  
synchronous clear, and clock enable — designed as a reusable digital design component.

---

## Overview

Shift registers are fundamental building blocks in digital design, used everywhere  
from serial communication protocols to CPU pipelines. This implementation goes beyond  
a basic shift register by adding production-ready control signals like clock enable  
and synchronous clear, making it suitable for real hardware integration.

---

## Real World Applications

| Mode | Where It's Used |
|------|----------------|
| SISO | UART TX/RX, SPI data lines, I2C |
| SIPO | Keyboard scanning, sensor data deserialization |
| PISO | LED matrix drivers (WS2812), data serialization for transmission |
| PIPO | CPU general purpose registers, pipeline stage buffers |

Clock Enable is used in FPGAs to gate logic without using the clock line directly.  
Synchronous Clear is used in ASICs where glitch-free resets are critical.

---

## Features

- Parameterized width (default 8-bit, works for any width)
- 4 operation modes: SISO, SIPO, PISO, PIPO
- Left and right shift direction control
- Synchronous parallel load
- Active high asynchronous reset
- Synchronous clear (sync_clr) for glitch-free clearing
- Clock enable (CE) for power-efficient gating

---

## Port Description

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| clk | Input | 1 | Clock signal. All inputs sampled at posedge |
| reset | Input | 1 | Active high async reset. Clears register immediately |
| sync_clr | Input | 1 | Synchronous clear. Clears register on next posedge |
| ce | Input | 1 | Clock enable. When low, register holds its value |
| load | Input | 1 | When high, loads data_in into register in one cycle |
| mode | Input | 2 | Operation mode selector (see table below) |
| shift_dir | Input | 1 | 0 = Left shift, 1 = Right shift |
| serial_in | Input | 1 | Serial input bit for SISO and SIPO modes |
| data_in | Input | 8 | Parallel input, loaded when load=1 |
| serial_out | Output | 1 | Serial output bit for SISO and PISO modes |
| data_out | Output | 8 | Parallel output, holds current register value |

---

## Operation Modes

| mode[1:0] | Mode | Full Name | Data In | Data Out | Use Case |
|-----------|------|-----------|---------|----------|----------|
| 00 | SISO | Serial In Serial Out | 1 bit/cycle via serial_in | 1 bit/cycle via serial_out | Serial comms |
| 01 | SIPO | Serial In Parallel Out | 1 bit/cycle via serial_in | All 8 bits via data_out | Deserializer |
| 10 | PISO | Parallel In Serial Out | 8 bits loaded via load | 1 bit/cycle via serial_out | Serializer |
| 11 | PIPO | Parallel In Parallel Out | 8 bits loaded via load | All 8 bits via data_out | Parallel register |

---

## Control Signal Priority

On every rising clock edge, signals are evaluated in this order:

| Priority | Signal | Type | Behaviour |
|----------|--------|------|-----------|
| 1 | reset | Asynchronous | Clears everything immediately, clock independent |
| 2 | ce = 0 | Synchronous | Register holds current value, no operation |
| 3 | sync_clr | Synchronous | Clears register cleanly on clock edge |
| 4 | load | Synchronous | Loads data_in into register in one cycle |
| 5 | mode | Synchronous | Shift logic executes based on selected mode |

---

## Shift Direction

| shift_dir | Direction | What Happens |
|-----------|-----------|-------------|
| 0 | Left | MSB exits via serial_out, serial_in enters at LSB |
| 1 | Right | LSB exits via serial_out, serial_in enters at MSB |

---

## How to Run on EDA Playground

1. Open [EDA Playground](https://edaplayground.com)
2. Set simulator to **Cadence Xcelium**
3. Paste `shift_register.sv` in the design editor
4. Add testbench in the testbench editor
5. Check **Save + Run**

---

## Project Structure
configurable-shift-register-verilog/

├── shift_register.sv      # Main design file

└── README.md              # Documentation


*(testbench coming soon)*

---

## Tools Used

- SystemVerilog (IEEE 1800-2012)
- Cadence Xcelium (via EDA Playground)

---

## Author

Prisha Bhatia  
ECE Student, Jaypee Institute of Information Technology  
DV Intern @ Signtitude, Bengaluru

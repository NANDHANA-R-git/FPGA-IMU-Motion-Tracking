# FPGA-Based Real-Time IMU Signal Processing for Indoor Motion Tracking

FPGA-based real-time IMU signal processing for indoor motion tracking using an 8-tap FIR low-pass filter implemented in Verilog on the PYNQ-Z2 platform.

---

## Overview

GPS signals are unreliable indoors, making IMU-based tracking a practical alternative. However, raw IMU measurements contain high-frequency noise that can affect motion detection accuracy.

This project implements an FPGA-based 8-tap FIR low-pass filter in Verilog to preprocess IMU signals in real time. The design serves as the first stage of a future indoor motion-tracking system on the PYNQ-Z2 platform.

---

## Hardware Platform

### FPGA Board
- PYNQ-Z2 Development Board
- Xilinx Zynq-7020 SoC

### FPGA Features Used
- Programmable Logic (PL)
- Verilog HDL Design Flow
- Vivado Synthesis and Implementation

### Target Application
Real-time preprocessing of IMU sensor signals for future indoor motion-tracking and step-detection systems.

---

## Project Objectives

- Implement an 8-tap FIR low-pass filter in Verilog
- Reduce high-frequency noise in IMU signals
- Demonstrate real-time signal processing on FPGA hardware
- Analyze timing, resource utilization, and power consumption
- Establish a foundation for future indoor motion-tracking applications

---

## Project Architecture

```text
IMU Sensor
     ↓
Data Acquisition
     ↓
Buffering
     ↓
FPGA FIR Filter
     ↓
Filtered Signal
     ↓
Motion / Step Detection
     ↓
Python Visualization
```

---

## FIR Filter Design

### Filter Type
8-Tap Low-Pass FIR Filter

### FIR Coefficients

```text
4, 12, 20, 28, 28, 20, 12, 4
```

### Input Signal

The current implementation uses artificially generated IMU-like acceleration samples created using a phase counter and pseudo-random noise generator for functional verification.

### Output

The filtered signal is displayed through the onboard LEDs of the PYNQ-Z2 board.

---

## Phase 1 Implementation

### Completed Tasks

- Designed and implemented an 8-tap FIR low-pass filter in Verilog
- Developed an IMU-like signal generator using a phase counter and LFSR noise source
- Created a simulation testbench for functional verification
- Synthesized and implemented the design in Vivado
- Generated FPGA bitstream for deployment on PYNQ-Z2
- Achieved timing closure after clock constraint optimization

---

## Repository Structure

```text
FPGA-IMU-Motion-Tracking
│
├── rtl/
│   └── fir8_lowpass.v
│
├── tb/
│   └── testbench.v
│
├── constraints/
│   └── constraints.xdc
│
├── reports/
│
├── screenshots/
│
└── docs/
```

---

## Results

### Resource Utilization

| Resource | Count |
|----------|--------|
| LUTs | 142 |
| Flip-Flops | 104 |

### Power Consumption

| Metric | Value |
|----------|----------|
| Estimated Power | ~0.108 W |

### Timing Performance

| Metric | Value |
|----------|----------|
| Clock Period | 12 ns |
| Operating Frequency | 83.33 MHz |
| Worst Negative Slack (WNS) | +1.186 ns |
| Total Negative Slack (TNS) | 0.000 ns |
| Failing Endpoints | 0 |

✅ Timing Closure Achieved Successfully

---

## Current Limitations

- Uses synthetic IMU-like input data
- Real IMU integration has not yet been completed
- Hardware validation with live sensor data is pending
- Motion and step detection algorithms are not yet implemented

---

## Future Work

### Phase 2

- Integrate MPU-6050 IMU sensor
- Acquire real acceleration and gyroscope data
- Filter live IMU measurements using FPGA hardware
- Implement motion and step detection algorithms
- Develop Python-based visualization tools
- Complete Cadence implementation flow
- Evaluate latency, filtering quality, and hardware resource utilization

---

## Tools Used

- Verilog HDL
- Vivado Design Suite
- PYNQ-Z2 Development Board
- Git & GitHub

---

## Author

**Nandhana**  
B.Tech Electronics and Communication Engineering

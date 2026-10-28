# SystemVerilog FIFO Verification

## Overview

This project implements an 8-bit wide, 8-entry FIFO and a SystemVerilog testbench for functional verification.

The testbench uses an object-oriented architecture with transaction generation, a driver, a monitor, and a queue-based reference model in the scoreboard.

## Design Specifications

| Parameter | Value |
|---|---|
| FIFO depth | 8 entries |
| Data width | 8 bits |
| FIFO count width | 4 bits |
| Clock period | 10 ns |
| Clock frequency | 100 MHz |

## Testbench Architecture

- **FifoTransaction:** Represents FIFO input transactions and stores the observed outputs.
- **Generator:** Creates stimulus for reset, normal writes, full and empty conditions, and simultaneous read and write operations.
- **Driver:** Applies transactions to the DUT through a virtual interface.
- **Monitor:** Samples the inputs and outputs of the DUT.
- **Scoreboard:** Uses a SystemVerilog queue as a reference model and checks the FIFO count and status flags.
- **Interface:** Connects the verification components to the DUT.

## Verification Scenarios

The test sequence contains 21 transactions covering:

- FIFO reset.
- Filling the FIFO to capacity.
- Attempting a write while full.
- Simultaneous read and write while full.
- Reading until the FIFO becomes empty.
- Attempting a read while empty.
- Simultaneous read and write while empty.

## Project Structure

```text
systemverilog-fifo-verification/
├── rtl/
│   └── FIFO.sv
├── tb/
│   ├── fifo_if.sv
│   ├── fifo_transaction.sv
│   ├── generator.sv
│   ├── driver.sv
│   ├── monitor.sv
│   ├── scoreboard.sv
│   ├── fifo_tb_pkg.sv
│   └── tb.sv
├── docs/
│   └── screenshots/
├── README.md
└── .gitignore
```

## Simulation

The testbench is intended to be compiled using Synopsys VCS.

From the repository root, run:

```bash
vcs -sverilog +incdir+tb \
    tb/fifo_if.sv \
    tb/fifo_tb_pkg.sv \
    rtl/FIFO.sv \
    tb/tb.sv \
    -o simv
```

Run the simulation:

```bash
./simv
```

## Tools and Languages

- SystemVerilog
- Synopsys VCS
- Object-oriented testbench development
- Mailboxes and virtual interfaces
- Queue-based reference model
- Scoreboard-based checking

## Results

Simulation results and waveform screenshots can be added to `docs/screenshots/` after running and validating the testbench.

## Future Improvements

- Add additional randomized scenarios.
- Expand coverage of simultaneous read and write operations.
- Add functional coverage.
- Improve the final verification summary.

# Lab 5: Parameterized Multiplexers

## Overview

You will write **one** mux module that works at any bit width, then test it at **4 bits and 8 bits** with four self-checking testbenches. This lab is **simulation only**: nothing is programmed onto the Basys 3.

New Verilog: `parameter`, `localparam`, `always @(*)`, and `case`.

| Item | Points | Due |
|---|---|---|
| Prelab 5.1 Quiz | 30 | Thu 9/24, start of your lab section (01: 2:00 PM · 02: 11:00 AM) |
| Lab 5: In-lab Instructions (CI) | 80 | Thu 10/1, 11:59 PM |
| Lab 5: Waveform Screenshots (PDF) | 20 | Thu 10/1, 11:59 PM |

**Late policy:** 10% of the possible points per day late (any part of a day counts as a day). For GitHub-graded work, the time of your last push is the submission time.

---

## Before You Start

Complete the **Lab 5 Prelab** in Canvas (video + quiz). Full instructions, due dates and the PDF upload are in the Canvas **Lab 5** module.

---

## What You Edit

| # | File | What to write |
|---|---|---|
| 1 | `rtl/mux2.v` | `always @(*)` block with a `case` on `sel` |
| 2 | `rtl/mux4.v` | `always @(*)` block with a `case` on `sel`, including `default` |
| 3 | `tb/mux_2to1_4bit_tb.v` | set `localparam N = 4`; instantiate `mux2` as `UUT` |
| 4 | `tb/mux_2to1_8bit_tb.v` | set `localparam N = 8`; instantiate `mux2` as `UUT` |
| 5 | `tb/mux_4to1_4bit_tb.v` | set `localparam N = 4`; instantiate `mux4` as `UUT` |
| 6 | `tb/mux_4to1_8bit_tb.v` | set `localparam N = 8`; instantiate `mux4` as `UUT` |

Do not change the module headers, port names or anything outside the TODO sections.

---

## Step 1: Write the Mux Logic

**`mux2`** (`sel` is 1 bit):

| `sel` | `out` |
|---|---|
| 0 | `a` |
| 1 | `b` |

**`mux4`** (`sel` is 2 bits):

| `sel` | `out` |
|---|---|
| `2'b00` | `a` |
| `2'b01` | `b` |
| `2'b10` | `c` |
| `2'b11` | `d` |
| `default` | all zeros: `{N{1'b0}}` |

Use this structure. `out` is already declared `output reg`, which is required because it is assigned inside `always`:

```verilog
always @(*) begin
    case (sel)
        // one line per sel value:  value: out = input;
        default: out = {N{1'b0}};
    endcase
end
```

## Step 2: Finish the Four Testbenches

Each testbench has two TODOs:

1. **Set the width.** Change `localparam N = 1;` to the width in the file name (4 or 8).
2. **Instantiate the mux** as `UUT`, overriding `N` and connecting every port by name:

```verilog
module_name #(.N(N)) UUT (
    .port(signal),
    ...
);
```

`mux2` ports: `a`, `b`, `sel`, `out`. `mux4` ports: `a`, `b`, `c`, `d`, `sel`, `out`. In the testbenches, each signal has the same name as its port.

> **CI checks the width.** A testbench left at `N = 1` still prints TEST PASSED, because the values are cut down to 1 bit. The CI job also requires the header line to show the correct `(N=4)` or `(N=8)`, and fails otherwise.

## Step 3: Simulate and Capture Waveforms

1. Create a Vivado project **outside** your repo folder, targeting the **Basys3** board.
2. Add `rtl/` as **design sources** and `tb/` as **simulation sources**. There is no constraint file, because nothing is synthesized.
3. For each testbench, right-click it → **Set as Top** → **Run Behavioral Simulation**.
4. Confirm the Tcl console ends with **`TEST PASSED`**.
5. Capture a waveform screenshot, following the rules below.

**Screenshot rules** (for the PDF):

- One screenshot per testbench, **4 total**
- Show every input, plus `sel` and `out`
- Set the radix of all signals to **Decimal** (select signals → right-click → Radix → Unsigned Decimal)
- **Zoom Fit**, then zoom in until the values are readable
- Label each screenshot with its testbench name

Put all four in one document and export it as a **single PDF**.

## Step 4: Push and Submit

1. **Commit and push** with GitHub Desktop.
2. Open the **Actions** tab. All four jobs must be green.
3. Upload your PDF to **Lab 5: Waveform Screenshots** in Canvas.

---

## Grading

| Component | Points |
|---|---|
| `Test 2-to-1 4-bit Mux` CI job | 20 |
| `Test 2-to-1 8-bit Mux` CI job | 20 |
| `Test 4-to-1 4-bit Mux` CI job | 20 |
| `Test 4-to-1 8-bit Mux` CI job | 20 |
| **Lab 5: In-lab Instructions** | **80** |
| **Lab 5: Waveform Screenshots** (PDF upload) | **20** |

---

## Troubleshooting

| Symptom | Likely cause |
|---|---|
| `out` is `X` or `Z` in every test | `UUT` not instantiated, or a port not connected |
| CI fails with `localparam N must be ...` | `N` still set to 1, or the wrong width for that file |
| Compile error: *cannot assign to wire* | assigning `out` outside the `always` block, or the `reg` was removed from the header |
| Only some `sel` values fail | a missing or mistyped `case` item (for example, `2'b10` typed as `2'b01`) |
| Simulation runs the wrong testbench | right-click the testbench you want → **Set as Top**, then relaunch the simulation |

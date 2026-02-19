# Exercise: Parameterized Multiplexer

## Objective

In this exercise you will implement two **parameterized multiplexers** in Verilog using `case` statements, then **instantiate** each one in its testbench with the correct parameter override.

You will learn three important Verilog concepts:

- **`parameter`** — Make modules reusable by defining configurable constants
- **`localparam`** — Set a constant in the calling module to feed into a parameter override
- **`case` statement** — Select between multiple options based on a control signal

This is a **simulation-only** exercise — there is no FPGA programming. You will edit two RTL files and four testbench files.

---

## Background

### Parameters

A `parameter` lets you define a constant that can be overridden when the module is instantiated. This makes modules reusable for different bit widths:

```verilog
module mux2 #(
    parameter N = 1     // default: 1-bit data
)(
    input  [N-1:0] a,
    input  [N-1:0] b,
    input          sel,
    output reg [N-1:0] out
);
```

### localparam and Instantiation

In a testbench or calling module, use `localparam` to define a constant, then pass it as a parameter override:

```verilog
localparam N = 8;           // set the desired bit width

mux2 #(.N(N)) UUT (        // override parameter N
    .a(a),
    .b(b),
    .sel(sel),
    .out(out)
);
```

The same module definition works for any bit width — 1-bit, 4-bit, 8-bit, 32-bit, etc. — without rewriting the logic.

### The `case` Statement

A `case` statement selects between multiple options based on a signal's value. It must be inside an `always` block:

```verilog
always @(*) begin
    case (sel)
        1'b0: out = a;
        1'b1: out = b;
        default: out = {N{1'b0}};
    endcase
end
```

Key points:
- `always @(*)` means "re-evaluate whenever any input changes" (combinational logic)
- The output must be declared as `reg` when assigned inside an `always` block (even though this creates combinational logic, not a register)
- `default` catches any unhandled cases — good design practice

### 2-to-1 Mux Truth Table

```
sel | out
----+-----
 0  |  a
 1  |  b
```

### 4-to-1 Mux Truth Table

```
sel  | out
-----+-----
 00  |  a
 01  |  b
 10  |  c
 11  |  d
```

---

## Your Task

Complete **six files** — two RTL modules and four testbenches:

### 1. `rtl/mux2.v` — 2-to-1 Multiplexer

The module header is provided. Add a `case` statement inside an `always @(*)` block that assigns `out` based on `sel`:
- `sel = 0` → `out = a`
- `sel = 1` → `out = b`

### 2. `rtl/mux4.v` — 4-to-1 Multiplexer

The module header is provided. Add a `case` statement inside an `always @(*)` block that assigns `out` based on `sel`:
- `sel = 2'b00` → `out = a`
- `sel = 2'b01` → `out = b`
- `sel = 2'b10` → `out = c`
- `sel = 2'b11` → `out = d`
- `default` → `out = 0`

### 3. Testbench Instantiation (all four testbenches)

Each testbench has two TODOs:

1. **Set `localparam N`** to the correct bit width (4 or 8, depending on the testbench)
2. **Write the instantiation statement** for the mux module with the parameter override and port connections

The port names and instance name (`UUT`) are specified in each file's TODO comments.

---

## File Structure

```
ParamMux/
├── rtl/
│   ├── mux2.v                 ← YOU EDIT
│   └── mux4.v                 ← YOU EDIT
├── tb/
│   ├── mux_2to1_4bit_tb.v     ← YOU EDIT (localparam + instantiation)
│   ├── mux_2to1_8bit_tb.v     ← YOU EDIT (localparam + instantiation)
│   ├── mux_4to1_4bit_tb.v     ← YOU EDIT (localparam + instantiation)
│   └── mux_4to1_8bit_tb.v     ← YOU EDIT (localparam + instantiation)
├── .github/
│   └── workflows/
│       └── test.yml            # CI runs all 4 testbenches
├── .gitignore
└── README.md
```

---

## Running Locally (Vivado)

1. Create a Vivado project and add the RTL and testbench sources
2. Run **Behavioral Simulation** for each testbench
3. Set all signals to **Decimal** radix in the waveform viewer
4. Capture a waveform screenshot for each testbench

Each testbench will print a table of test vectors and end with either:
- **`TEST PASSED`** — All outputs matched the expected values
- **`TEST FAILED`** — One or more outputs were incorrect

---

## Submission

1. Complete `rtl/mux2.v` and `rtl/mux4.v` with your implementations
2. Complete the `localparam` and instantiation in all four testbenches
3. Simulate in Vivado — capture waveform screenshots (4 total)
4. Commit and push to GitHub
5. Check the Actions tab — all four CI checks should show green

### Grading

| Test | Points |
|------|--------|
| 2-to-1, 4-bit Mux | 25 |
| 2-to-1, 8-bit Mux | 25 |
| 4-to-1, 4-bit Mux | 25 |
| 4-to-1, 8-bit Mux | 25 |
| **Total** | **100** |

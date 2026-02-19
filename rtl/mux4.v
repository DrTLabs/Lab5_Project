//============================================================================
// Module: Parameterized 4-to-1 Multiplexer
//
// Description:
//   A parameterized N-bit, 4-to-1 multiplexer. The parameter N sets the
//   bit width of the inputs and output.
//
// Parameters:
//   N : bit width of each input and the output (default = 1)
//
// Ports:
//   a   [N-1:0]  - Input 0 (selected when sel = 2'b00)
//   b   [N-1:0]  - Input 1 (selected when sel = 2'b01)
//   c   [N-1:0]  - Input 2 (selected when sel = 2'b10)
//   d   [N-1:0]  - Input 3 (selected when sel = 2'b11)
//   sel [1:0]    - 2-bit select signal
//   out [N-1:0]  - Selected output
//
// Truth Table (1-bit example, N=1):
//
//   sel  | out
//   -----+-----
//   2'b00|  a
//   2'b01|  b
//   2'b10|  c
//   2'b11|  d
//
// Key Verilog Concepts:
//   - parameter: Defines a configurable constant (N) that can be
//     overridden at instantiation using #(.N(value))
//   - case statement: Selects between multiple options based on a signal
//   - default: Catches any unhandled cases (good design practice)
//
//============================================================================

module mux4 #(
    parameter N = 1     // Bit width of each input/output
)(
    input  [N-1:0] a,      // Input 0
    input  [N-1:0] b,      // Input 1
    input  [N-1:0] c,      // Input 2
    input  [N-1:0] d,      // Input 3
    input  [1:0]   sel,    // Select signal
    output reg [N-1:0] out // Selected output
);

    // TODO: Write a case statement that assigns 'out' based on 'sel'.
    //       When sel is 2'b00, out should equal a.
    //       When sel is 2'b01, out should equal b.
    //       When sel is 2'b10, out should equal c.
    //       When sel is 2'b11, out should equal d.
    //       Include a default case that sets out to all zeros.
    //
    // Hint:
    //   always @(*) begin
    //       case (sel)
    //           ...
    //           default: ...
    //       endcase
    //   end

endmodule

//============================================================================
// Module: Parameterized 2-to-1 Multiplexer
//
// Description:
//   A parameterized N-bit, 2-to-1 multiplexer. The parameter N sets the
//   bit width of the inputs and output.
//
// Parameters:
//   N : bit width of each input and the output (default = 1)
//
// Ports:
//   a   [N-1:0]  - Input 0 (selected when sel = 0)
//   b   [N-1:0]  - Input 1 (selected when sel = 1)
//   sel           - 1-bit select signal
//   out [N-1:0]  - Selected output
//
// Truth Table (1-bit example, N=1):
//
//   sel | out
//   ----+-----
//    0  |  a
//    1  |  b
//
// Key Verilog Concepts:
//   - parameter: Defines a configurable constant (N) that can be
//     overridden at instantiation using #(.N(value))
//   - case statement: Selects between multiple options based on a signal
//
//============================================================================

module mux2 #(
    parameter N = 1     // Bit width of each input/output
)(
    input  [N-1:0] a,      // Input 0
    input  [N-1:0] b,      // Input 1
    input          sel,    // Select signal
    output reg [N-1:0] out // Selected output
);

    // TODO: Write a case statement that assigns 'out' based on 'sel'.
    //       When sel is 0, out should equal a.
    //       When sel is 1, out should equal b.
    //
    // Hint:
    //   always @(*) begin
    //       case (sel)
    //           ...
    //       endcase
    //   end

endmodule

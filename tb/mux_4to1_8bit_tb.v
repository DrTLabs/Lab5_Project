//============================================================================
// Testbench: 4-to-1, 8-bit Mux  (N=8)
//
// Self-checking testbench that verifies the parameterized 4-to-1 mux
// with 8-bit inputs.
//============================================================================

`timescale 1ns/1ps

module mux_4to1_8bit_tb;

    //------------------------------------------------------------------------
    // Parameters
    //------------------------------------------------------------------------
    // TODO: Set the localparam N to the correct bit width for this test (8)
    localparam N = 1;   // <-- Change this value

    //------------------------------------------------------------------------
    // Signal Declarations
    //------------------------------------------------------------------------
    reg  [N-1:0] a, b, c, d;  // Four N-bit inputs
    reg  [1:0]   sel;          // 2-bit select
    wire [N-1:0] out;          // N-bit output
    reg  [N-1:0] expected;     // Golden model output

    integer error_count;
    integer test_num;
    integer i;

    //------------------------------------------------------------------------
    // Unit Under Test (UUT)
    //------------------------------------------------------------------------
    // TODO: Instantiate the mux4 module here.
    //   - Override parameter N with the localparam N above
    //   - Use instance name: UUT
    //   - Connect all ports by name

    //------------------------------------------------------------------------
    // Test Stimulus
    //------------------------------------------------------------------------
    initial begin
        error_count = 0;
        test_num = 0;

        $display("========================================================");
        $display("4-to-1, 8-bit Mux Testbench  (N=%0d)", N);
        $display("========================================================");
        $display(" Test |   a  |   b  |   c  |   d  | sel | Expected | Actual | Status");
        $display("------+------+------+------+------+-----+----------+--------+-------");

        // Round 1: a=8'hEF, b=8'hBE, c=8'hAD, d=8'hDE
        a = 8'hEF; b = 8'hBE; c = 8'hAD; d = 8'hDE;
        for (i = 0; i < 4; i = i + 1) begin
            sel = i; #10; check_output();
        end

        // Round 2: a=8'h55, b=8'hAA, c=8'h00, d=8'hFF
        a = 8'h55; b = 8'hAA; c = 8'h00; d = 8'hFF;
        for (i = 0; i < 4; i = i + 1) begin
            sel = i; #10; check_output();
        end

        // Round 3: a=8'h78, b=8'h56, c=8'h34, d=8'h12
        a = 8'h78; b = 8'h56; c = 8'h34; d = 8'h12;
        for (i = 0; i < 4; i = i + 1) begin
            sel = i; #10; check_output();
        end

        // Round 4: All zeros except one input
        a = 8'h00; b = 8'hFF; c = 8'h00; d = 8'h00;
        for (i = 0; i < 4; i = i + 1) begin
            sel = i; #10; check_output();
        end

        // Round 5: Descending byte values
        a = 8'h00; b = 8'h40; c = 8'h80; d = 8'hC0;
        for (i = 0; i < 4; i = i + 1) begin
            sel = i; #10; check_output();
        end

        // Results
        $display("========================================================");
        if (error_count == 0) begin
            $display("TEST PASSED - All %0d vectors correct!", test_num);
        end else begin
            $display("TEST FAILED - %0d errors out of %0d vectors", error_count, test_num);
        end
        $display("========================================================");

        if (error_count == 0)
            $finish(0);
        else
            $finish(1);
    end

    //------------------------------------------------------------------------
    // Output Checking Task
    //------------------------------------------------------------------------
    task check_output;
        begin
            test_num = test_num + 1;
            case (sel)
                2'b00: expected = a;
                2'b01: expected = b;
                2'b10: expected = c;
                2'b11: expected = d;
            endcase
            if (out !== expected) begin
                $display("  %3d |  %h  |  %h  |  %h  |  %h  | %b  |    %h    |   %h   | FAIL",
                         test_num, a, b, c, d, sel, expected, out);
                error_count = error_count + 1;
            end else begin
                $display("  %3d |  %h  |  %h  |  %h  |  %h  | %b  |    %h    |   %h   | ok",
                         test_num, a, b, c, d, sel, expected, out);
            end
        end
    endtask

endmodule

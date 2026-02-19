//============================================================================
// Testbench: 2-to-1, 8-bit Mux  (N=8)
//
// Self-checking testbench that verifies the parameterized 2-to-1 mux
// with 8-bit inputs.
//============================================================================

`timescale 1ns/1ps

module mux_2to1_8bit_tb;

    //------------------------------------------------------------------------
    // Parameters
    //------------------------------------------------------------------------
    // TODO: Set the localparam N to the correct bit width for this test (8)
    localparam N = 1;   // <-- Change this value

    //------------------------------------------------------------------------
    // Signal Declarations
    //------------------------------------------------------------------------
    reg  [N-1:0] a, b;        // Two N-bit inputs
    reg          sel;          // 1-bit select
    wire [N-1:0] out;          // N-bit output
    reg  [N-1:0] expected;     // Golden model output

    integer error_count;
    integer test_num;

    //------------------------------------------------------------------------
    // Unit Under Test (UUT)
    //------------------------------------------------------------------------
    // TODO: Instantiate the mux2 module here.
    //   - Override parameter N with the localparam N above
    //   - Use instance name: UUT
    //   - Connect all ports by name

    //------------------------------------------------------------------------
    // Test Stimulus
    //------------------------------------------------------------------------
    initial begin
        error_count = 0;
        test_num = 0;

        $display("================================================");
        $display("2-to-1, 8-bit Mux Testbench  (N=%0d)", N);
        $display("================================================");
        $display(" Test |   a  |   b  | sel | Expected | Actual | Status");
        $display("------+------+------+-----+----------+--------+-------");

        // Pattern 1: a=8'h55, b=8'hAA
        a = 8'h55; b = 8'hAA;
        sel = 0; #10; check_output();
        sel = 1; #10; check_output();

        // Pattern 2: a=8'h00, b=8'hFF
        a = 8'h00; b = 8'hFF;
        sel = 0; #10; check_output();
        sel = 1; #10; check_output();

        // Pattern 3: a=8'hC3, b=8'h3C
        a = 8'hC3; b = 8'h3C;
        sel = 0; #10; check_output();
        sel = 1; #10; check_output();

        // Pattern 4: a=8'h34, b=8'h12
        a = 8'h34; b = 8'h12;
        sel = 0; #10; check_output();
        sel = 1; #10; check_output();

        // Pattern 5: a=8'hAD, b=8'hDE
        a = 8'hAD; b = 8'hDE;
        sel = 0; #10; check_output();
        sel = 1; #10; check_output();

        // Results
        $display("================================================");
        if (error_count == 0) begin
            $display("TEST PASSED - All %0d vectors correct!", test_num);
        end else begin
            $display("TEST FAILED - %0d errors out of %0d vectors", error_count, test_num);
        end
        $display("================================================");

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
            expected = sel ? b : a;
            if (out !== expected) begin
                $display("  %3d |  %h  |  %h  |  %b  |    %h    |   %h   | FAIL",
                         test_num, a, b, sel, expected, out);
                error_count = error_count + 1;
            end else begin
                $display("  %3d |  %h  |  %h  |  %b  |    %h    |   %h   | ok",
                         test_num, a, b, sel, expected, out);
            end
        end
    endtask

endmodule

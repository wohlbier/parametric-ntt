module dump();
    initial begin
        $dumpfile ("NTTN_test.vcd");
        $dumpvars (0, NTTN_test);
        #1;
    end
endmodule

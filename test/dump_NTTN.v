module dump();
    initial begin
        $dumpfile ("test_NTTN.vcd");
        $dumpvars (0, test_NTTN);
        #1;
    end
endmodule

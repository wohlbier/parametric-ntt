module dump();
    initial begin
        $dumpfile ("vcd/ShiftReg.vcd");
        $dumpvars (0, ShiftReg);
        #1;
    end
endmodule

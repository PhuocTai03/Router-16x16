`timescale 1ns / 1ps
`include "router_io.sv"

module router_test_top();
    bit         clk;
    initial     clk = 0;
    always #10  clk = ~clk;
    
    //old
//    router_io_oldversion   top_io      (clk);
//    test        t           (top_io.tb);
    //
    
    //new
    router_io   top_io      (clk);
    testExtra   t(top_io);
    //
    router DUT(
                .clk        (clk),
                .reset_n    (top_io.reset_n), 
                .din        (top_io.din), 
                .valid_n    (top_io.valid_n), 
                .frame_n    (top_io.frame_n), 
                .dout       (top_io.dout), 
                .valido_n   (top_io.valido_n), 
                .frameo_n   (top_io.frameo_n)
               );
endmodule
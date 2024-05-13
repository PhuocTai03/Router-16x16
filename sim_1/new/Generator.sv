//`timescale 1ns / 1ps
//`ifndef GENERATOR_SV
//`define GENERATOR_SV
//`include "Packet.sv"

//class Generator;
//    virtual router.io.tb rtr_io;
//    bit [3:0] sa, da;
//    bit [7:0] pkt2cmp[32]; //maximum 4bytes
//    pkt_mbox out_box;
    
//    extern function new();
//    extern virtual task start();
//    extern task gen();
//endclass
//function Generator::new();
    
//endfunction
//task Generator::start();
//    integer i;
//    fork
//        while(run_for_n_packets <= 0);
//        for( i = 0; i < run_for_n_packets; i = i + 1)
//            gen(); 
//    join
//endtask
//task Generator::gen();
//    Packet pkt2send = new();
//    out_box.put(pkt2send); 
    
//endtasnk
//`endif
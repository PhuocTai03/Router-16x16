`timescale 1ns / 1ps
`ifndef RECEIVER_BASE
`define RECEIVER_BASE
`include "router_test.h"
`include "Packet.sv"
class ReceiverBase;
    virtual router_io.RECEIVER rtr_io;
    string name;
    bit [3:0] sa, da;
    logic [7:0] payload[$];
    Packet pkt2send;
    
    function new (virtual router_io.RECEIVER rtr_io, input string name);
        this.name   = name;
        this.rtr_io = rtr_io;
    endfunction
endclass: ReceiverBase
`endif

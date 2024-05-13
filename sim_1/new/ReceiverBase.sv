`timescale 1ns / 1ps
`include "router_test.h"
class ReceiverBase;
    virtual router.io.TB rtr_io;
    string name;
    bit [3:0] sa, da;
    logic [7:0] payload[$];
    Packet pkt2send;
    
    extern function new (virtual router_io.tb rtr_io, string name);
endclass: ReceiverBase
    
function ReceiverBase:: new(virtual router_io.tb rtr_io, string name);
    this.name   = name;
    this.rtr_io = rtr_io;
endfunction


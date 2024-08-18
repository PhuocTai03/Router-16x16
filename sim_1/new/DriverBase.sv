`timescale 1ns / 1ps
`ifndef DRIVER_BASE
`define DRIVER_BASE
`include "router_test.h"
`include "Packet.sv"
class DriverBase;
    virtual router_io.DRIVER rtr_io;
    string name;
    bit [3:0] sa, da;
    bit [7:0] payload[$];
    Packet pkt2send;
        
    function new (virtual router_io.DRIVER rtr_io, input string name);
        this.rtr_io = rtr_io;
        this.name   = name;
    endfunction
endclass: DriverBase
`endif

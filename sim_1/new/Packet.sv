`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2024 12:07:42 AM
// Design Name: 
// Module Name: Packet
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`ifndef INC_PACKET_SV
`define INC_PACKET_SV

class Packet;
    rand bit [3:0]          sa, da;
    rand logic [7:0]        payload[$];
    string                  name;
    
    extern function         new(string name);
    extern function bit     compare(Packet pkt2cmp, ref string message);
    extern function void    display(string prefix = "NOTE");
    
endclass: Packet
//////////////////////////////////////////////
function Packet::new(string name);
    this.name = name;
    sa = $urandom;
    da = $urandom;
    foreach(payload[i])
        payload[i] = $urandom;
endfunction: new

function bit Packet::compare(Packet pkt2cmp, ref string message);
    bit temp1, temp2;
    while (pkt2cmp.payload.size()) begin
        temp1 = this.payload.pop_back();
        temp2 = pkt2cmp.payload.pop_back();
        if(temp1 == temp2)
            $display("Transfer successul");
            //$display ("Port3 => Port7 : Transfer successed [din = %0d, dout = %0d]", temp3, temp4);
        else begin
            $display("Transfer failed");
            //$display ("Port3 => Port7 : Transfer failed    [din = %0d, dout = %0d]", temp3, temp4);
            break;
        end
    end
endfunction: compare

function void Packet::display (string prefix = "NOTE");
    $display("This is display() function");
endfunction: display
    
`endif
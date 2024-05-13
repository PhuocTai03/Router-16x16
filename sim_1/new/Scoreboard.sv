`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2024 10:29:40 PM
// Design Name: 
// Module Name: Scoreboard
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
class Scoreboard;
    pkt_mbox driver_mbox [16];
    pkt_mbox receiver_mbox [16];
    extern virtual function new();
    extern task start();
endclass

function Scoreboard::new();
    foreach(driver_mbox[i])
        driver_mbox[i] = new();
    foreach(receiver_mbox[i])
        receiver_mbox[i] = new();
        
endfunction

task Scoreboard::start();
    fork
        while(1) begin
//            A Driver will deposit the Packet objects it has just sent to the DUT into the driver_mbox
//            mailbox. A Receiver will deposit the Packet object it has just retrieved from the DUT into the
//            receiver_mbox mailbox.
//            When the Scoreboard finds a Packet object in the receiver_mbox, it will first save this object
//            handle as pkt2cmp. Then, it will push all Packet objects found in the driver_mbox onto a
//            refPkt[$] queue. Afterwards, on the basis ofthe output port address (da) in pkt2cmp object, it
//            will try to locate the corresponding reference Packet in refPkt [$] and compare the content. If
//            no corresponding reference Packet is found, an error is reported.
//            When the number of Packet objects checked matches the global variable
//            run_for_n_packets, an event flag called DONE is triggered. This DONE flag will allow
//            the simulation to terminate gracefully at the appropriate time. 
        end
    join
endtask


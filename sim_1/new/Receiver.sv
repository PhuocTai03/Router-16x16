//`timescale 1ns / 1ps
//`ifndef INC_RECEIVER_SV
//`define INC_RECEIVER_SV
//`include "ReceiverBase.sv"

//class Receiver extends ReceiverBase;
//    bit [7:0] pkt2cmp[$];
//    pkt_mbox out_box;
    
//    extern function new (string name, int port_id, pkt_mbox out_box);
//    extern virtual task start();
//    extern task recv();
//    extern task get_payload();
//endclass

//function Receiver::new(string name, int port_id, pkt_mbox out_box);
//    super.new(rtr_io, name);
//    //if (TRACE_0N) $display("[TRACE]%t %s:%m", $realtime, name);
//    this.da = port_id;
//    this.out_box = out_box;
//endfunction

//task Receiver::start();
//    //if (TRACE_0N) $display("[TRACE]%t %s:%m", $realtime, name);
//    fork
//        while(1) begin
//            recv();
//            out_box.put(pkt2cmp);
//        end
//    join
//endtask
//task Receiver::recv();
//    @(negedge rtr_io.cb.frameo_n[da]);                       
//        get_payload();  
//endtask
//task Receiver::get_payload();
//    bit [7:0] temp1;
//    bit temp2[$];
//    integer i;
//    while(!rtr_io.cb.valido_n[da]) begin
//        temp2.push_front(rtr_io.cb.dout[da]);
//        #20;                         //get payload every 20ns
//    end
//    temp2.push_front(rtr_io.cb.dout[da]); //get last bit after posedge valido_n
//    while(temp2.size()) begin
//        for(i = 0; i < 8; i = i + 1) begin
//            temp1 = {temp2.pop_back(), temp1[7:1]};
//        end
//        pkt2cmp.push_front(temp1);
//    end
//endtask
//`endif

`timescale 1ns / 1ps
`ifndef INC_RECEIVER_SV
`define INC_RECEIVER_SV
`include "ReceiverBase.sv"
class Receiver extends ReceiverBase;
    //properties
    bit [7:0]   pkt2cmp[$];
    pkt_mbox    out_box;
    
    //methods
    function new (
                    input string name, 
                    input int port_id, 
                    pkt_mbox out_box,
                    virtual router_io.RECEIVER rtr_io
                );
        super.new(rtr_io, name);
        this.da = port_id;
        this.out_box = out_box;
    endfunction
    
    task start();
        fork
            $display("[%0t] - Receiver[%0d] started", $time, this.da);
            begin
                Packet rcv_pkt;
                bit [7:0] byteGot;
                bit payload_queue[$];
                integer i;
                forever begin
                    @(negedge rtr_io.receiver_cb.frameo_n[da]);  
                    while(!rtr_io.receiver_cb.frameo_n[da]) begin
                        if(!rtr_io.receiver_cb.valido_n[da]) begin
                            payload_queue.push_front(rtr_io.receiver_cb.dout[da]);
                        end
                        @(rtr_io.receiver_cb);
                    end
                    while(payload_queue.size()) begin
                        for(i = 0; i < 8; i = i + 1) begin
                            byteGot = {payload_queue.pop_back(), byteGot[7:1]};
                        end
                        pkt2cmp.push_front(byteGot);
                    end
                    rcv_pkt = new("Received packet");
                    rcv_pkt.setPacket(0, this.da, pkt2cmp); //default sa = 0
                    //rcv_pkt.display("RECEIVER");
                    this.out_box.put(rcv_pkt);
                    
                    //clear queue
                    pkt2cmp.delete();
                end
            end
        join_none  
    endtask
endclass
`endif

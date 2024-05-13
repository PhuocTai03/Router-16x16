`timescale 1ns / 1ps
`ifndef INC_DRIVER_SV
`define INC_DRIVER_SV
`include "DriverBase.sv"
class Driver extends DriverBase;
    pkt_mbox in_box;
    pkt_mbox out_box;
    semaphore sem[];
    
    extern function new(string name, int port_id, semaphore sem[], pkt_mbox in_box, out_box, virtual router_io.TB rtr_io);
    extern virtual task start();
    extern task send();
    extern task send_addrs();
    extern task send_padding();
    extern task send_payload();
endclass

function Driver::new(string name, int port_id, semaphore sem[], pkt_mbox in_box, out_box, virtual router_io.TB rtr_io);
    super.new       (rtr_io, name);
    //if (TRACE_0N) $display("[TRACE]%t %s:%m", $realtime, name);
    this.sa         <= port_id;
    this.sem        <= sem;
    this.in_box     <= in_box;
    this.out_box    <= out_box;
endfunction

task Driver::start();
    //if (TRACE_0N) $display("[TRACE]%t %s:%m", $realtime, name);
    fork
        while(1) begin
            Packet pkt2send = in_box.get();
            if(pkt2send.sa != this.sa)
                continue;
            else begin
                this.da         = pkt2send.da;
                this.payload    = pkt2send.payload;
            end
            sem[da].get();
            send();
            out_box.put(pkt2send);
            sem[da].put();
        end
    join 
endtask
task Driver::send();
    rtr_io.cb.frame_n[sa] <= 1'b0;        
    send_addrs();
    send_padding();
    send_payload();
endtask
task Driver::send_addrs(); 
    rtr_io.cb.din[sa] <= da[3];
    #20 
    rtr_io.cb.din[sa] <= da[2];
    #20 
    rtr_io.cb.din[sa] <= da[1];
    #20 
    rtr_io.cb.din[sa] <= da[0];
endtask
task Driver::send_padding();
    #20
    rtr_io.cb.din[sa] <= 1'bx;
    #20
    rtr_io.cb.din[sa] <= 1'bx;
endtask
task Driver::send_payload();
    integer i, j;
    bit [7:0] temp1;
    for(i = 0; i <= payload.size(); i = i + 1) begin
        temp1 = payload.pop_back();
        for(j = 0; j < 8; j = j + 1) begin
            #20 
            rtr_io.cb.din[sa]      <= temp1[j];
            rtr_io.cb.valid_n[sa]  <= 1'b0;
        end   
    end
    //end of the packet
    rtr_io.cb.frame_n[sa] <= 1'b1;
    rtr_io.cb.valid_n[sa] <= 1'b1;
endtask   
`endif


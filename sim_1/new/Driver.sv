`timescale 1ns / 1ps
`ifndef INC_DRIVER_SV
`define INC_DRIVER_SV
`include "DriverBase.sv"
class Driver extends DriverBase;
    //properties
    pkt_mbox    in_box;
    pkt_mbox    out_box;
    semaphore   sem[];
    //event       DONE;
    
    //methods
    extern function new(
                            input string    name, 
                            input int       port_id, 
                            semaphore       sem[], 
                            pkt_mbox        in_box, out_box, 
                            virtual         router_io.DRIVER rtr_io
                        );
    extern virtual task start();
    extern task         send();
    extern task         send_addrs();
    //extern task         send_padding();
    extern task         send_payload();
endclass

function Driver::new(
                        input string    name, 
                        input int       port_id, 
                        semaphore       sem[], 
                        pkt_mbox        in_box, out_box, 
                        virtual         router_io.DRIVER rtr_io
                    );
    super.new       (rtr_io, name);
    this.sa         = port_id;
    this.sem        = sem;
    this.in_box     = in_box;
    this.out_box    = out_box;
endfunction

task Driver::start();
    fork
        $display("[%0t]- Driver[%0d] started", $time, this.sa);
        begin
            Packet pkt2send;
            while (this.in_box.num() > 0) begin
                this.in_box.get(pkt2send);
                if(pkt2send.sa != this.sa)
                    continue;
                else begin
                    this.da         = pkt2send.da;
                    this.payload    = pkt2send.payload;
                    sem[da].get(1);
                    send();
                    //pkt2send.display("DRIVER");
                    out_box.put(pkt2send);
                    sem[da].put();
                end
            end
        end
    join_none
endtask
task Driver::send();
    @(rtr_io.driver_cb);
    //$display("[%0t] - DRIVER: Sending 1 packet to DUT ...", $time);
    rtr_io.driver_cb.frame_n[this.sa] <= 1'b0;        
    send_addrs();
    //send_padding();
    send_payload();
    //$display("[%0t] - DRIVER: Sent 1 packet to DUT.", $time);
endtask
task Driver::send_addrs(); 
    rtr_io.driver_cb.din[this.sa] <= this.da[3];
    @(rtr_io.driver_cb);
    rtr_io.driver_cb.din[this.sa] <= this.da[2];
    @(rtr_io.driver_cb);
    rtr_io.driver_cb.din[this.sa] <= this.da[1];
    @(rtr_io.driver_cb);
    rtr_io.driver_cb.din[this.sa] <= this.da[0];
    @(rtr_io.driver_cb);
endtask
//task Driver::send_padding();
//    rtr_io.driver_cb.din[this.sa] <= 1'bx;
//    @(rtr_io.driver_cb);
//    rtr_io.driver_cb.din[this.sa] <= 1'bx;
//    @(rtr_io.driver_cb);
//endtask
task Driver::send_payload();
    integer i, j;
    bit [7:0] temp1;
    int payload_size = this.payload.size();
    if(payload_size) begin
        for(i = 0; i < payload_size; i = i + 1) begin
            temp1 = this.payload.pop_back();
            for(j = 0; j < 8; j = j + 1) begin
                rtr_io.driver_cb.valid_n[this.sa]   <= 1'b0;
                rtr_io.driver_cb.din[this.sa]       <= temp1[j];
                @(rtr_io.driver_cb);
            end   
        end
    end
    else begin
        $error("NO PAYLOAD FOULD IN THIS PACKET!");
    end
    rtr_io.driver_cb.valid_n[this.sa] <= 1'b1;
    rtr_io.driver_cb.frame_n[this.sa] <= 1'b1;
    @(rtr_io.driver_cb);
    rtr_io.driver_cb.frame_n[this.sa] <= 1'b1;
endtask  
`endif

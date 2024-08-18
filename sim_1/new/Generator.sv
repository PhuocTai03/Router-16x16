`timescale 1ns / 1ps
`ifndef GENERATOR_SV
`define GENERATOR_SV
`include "Packet.sv"
`include "router_test.h"
class Generator;
    //properties
    pkt_mbox    out_box[];
    event       DONE;
    
    //methods
    function new();
        this.out_box = new[16];
        foreach(this.out_box[i]) begin
            this.out_box[i] = new();
        end
    endfunction
    
    task start(input integer run_for_n_packets);
        begin
            $display("[%0t] - Generator started", $time);
            foreach(out_box[i]) begin
                integer index = 1;
                repeat(run_for_n_packets) begin
                    Packet pkt2send = new($sformatf("outbox[%0d]-pkt[%0d]", i, index));
                    if(!pkt2send.randomize())
                        $finish;
                    out_box[i].put(pkt2send); 
                    index = index + 1;
                end
            end
            -> DONE;
        end  
    endtask
endclass
`endif

//module generator_tb();
//    Generator gen_inst;
//    initial begin
//        gen_inst = new ();
//        gen_inst.start(15);
//        gen_inst.display();
//    end
//endmodule
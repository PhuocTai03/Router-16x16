`timescale 1ns / 1ps
`include "router_test.h"
`include "Packet.sv"
`include "Driver.sv"
`include "Receiver.sv"
`include "Generator.sv"
`include "Scoreboard.sv"
program automatic testExtra (router_io rtr_io);
    int         run_for_n_packets;
    
    semaphore   sem[];
    Generator   gen;
    Driver      drvr[];
    Receiver    rcvr[];
    Scoreboard  sb;
    
    pkt_mbox    driver_mbox;  
    pkt_mbox    receiver_mbox;
    
    initial begin
        run_for_n_packets   = 50;
        driver_mbox         = new();
        receiver_mbox       = new();
        sem                 = new[16];
        drvr                = new[16];
        rcvr                = new[16];
        gen                 = new();
        sb                  = new(driver_mbox, receiver_mbox);
        
        foreach(sem[i])
            sem[i] = new(1);
            
        foreach(drvr[i])
            drvr[i] = new($sformatf("drvr[%0d]", i), i, sem, gen.out_box[i], driver_mbox, rtr_io);
            
        foreach(rcvr[i])
            rcvr[i] = new($sformatf("rcvr[%0d]", i), i, receiver_mbox, rtr_io);
            
        reset();
        
        gen.start(run_for_n_packets);
        wait(gen.DONE.triggered);
        
        fork
            begin
                foreach(drvr[i]) begin
                    drvr[i].start();
                end
            end
            begin
                foreach(rcvr[i]) begin
                    rcvr[i].start();
                end
            end
        join
        
        #7000  //not optimize
        sb.start();
        wait(sb.DONE.triggered);
        $display("[%0t] - SCOREBOARD: done!", $time);
        #10000 $stop;
    end
    
    task reset();
        rtr_io.reset_n                  = 1'b0;
        rtr_io.driver_cb.frame_n       <= 16'hffff;
        rtr_io.driver_cb.valid_n       <= 16'hffff;//~('b0);
        #20 
        rtr_io.reset_n                 <= 1'b1;
        repeat (15) begin
            @(rtr_io.receiver_cb);   
            $display("[%0t] - Resetting ...", $time);
        end
    endtask
endprogram

`timescale 1ns / 1ps
`ifndef SCOREBOARD
`define SCOREBOARD
`include "router_test.h"
`include "Packet.sv"
class Scoreboard;
    // Properties
    pkt_mbox    driver_mbox;  
    pkt_mbox    receiver_mbox;
    Packet      drv_pkt_queue [$];
    Packet      rcv_pkt_queue [$];
    int         packets_checked;
    int         error_count;
    bit         found;
    event       DONE;
    
    // Methods
    function new(pkt_mbox drv_box, pkt_mbox rcv_box);
        this.driver_mbox        = drv_box;
        this.receiver_mbox      = rcv_box;
        this.packets_checked    = 0;
    endfunction
    task start();
        Packet drv_pkt = new ("drv");
        Packet rcv_pkt = new ("rcv");
        Packet temp_pkt = new ("temp");
        int drv_pkt_queue_size, rcv_pkt_queue_size;
        $display("[%0t] - Scoreboard started", $time);
        
        // Collect all packets from driver_mbox
        while(this.driver_mbox.try_get(drv_pkt)) begin
                drv_pkt_queue.push_back(drv_pkt);
        end
        while(this.receiver_mbox.try_get(rcv_pkt)) begin
                rcv_pkt_queue.push_back(rcv_pkt);
        end
        
        drv_pkt_queue_size = drv_pkt_queue.size();
        rcv_pkt_queue_size = rcv_pkt_queue.size();
        $display("Number of driver packets = %0d", drv_pkt_queue_size);
        $display("Number of receiver packets = %0d", rcv_pkt_queue_size);
        
        if (drv_pkt_queue_size == 0) begin
            $display("[%0t] - No driver packets to check. Scoreboard finished.", $time);
            -> DONE;
            return;
        end
        else if (rcv_pkt_queue_size == 0) begin
            $display("[%0t] - No receiver packets to check. Scoreboard finished.", $time);
            -> DONE;
            return;
        end
        foreach(drv_pkt_queue[i]) begin
            found = 0;
            foreach(rcv_pkt_queue[j]) begin
                // Compare
                if(rcv_pkt_queue[j].da != drv_pkt_queue[i].da)
                    continue;
                if(rcv_pkt_queue[j].payload != drv_pkt_queue[i].payload)
                    continue;
                
                // Matched
                $display("[%0t] - SCOREBOARD: Packet matched!", $time);
                drv_pkt_queue[i].display("DRV_MATCHED");
                rcv_pkt_queue[j].display("RCV_MATCHED");
                found = 1;
                packets_checked = packets_checked + 1;
                rcv_pkt_queue.delete(j);
                break;
            end
            if(found == 0) begin
                $display("[%0t] - ERROR: Packet not found in receiver queue", $time);
                drv_pkt_queue[i].display("Unmatched packet");
                error_count++;
            end
            else begin
                // Remove the checked packet from the driver queue
                drv_pkt_queue.delete(i);
                i--; // Adjust index to avoid skipping the next packet
            end
        end
        // Check if there are any remaining packets in the receiver queue
        if(rcv_pkt_queue.size() > 0) begin
            $display("[%0t] - ERROR: Extra packets found in receiver queue", $time);
            foreach(rcv_pkt_queue[i])
                rcv_pkt_queue[i].display($sformatf("Extra packet in receiver queue[%0d]", i));
            error_count += rcv_pkt_queue.size();
        end
        
        $display("[%0t] - Scoreboard finished. Packets checked: %0d, Errors: %0d", $time, packets_checked, error_count);
        -> DONE;
    endtask
endclass
`endif
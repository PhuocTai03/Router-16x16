`timescale 1ns / 1ps
`ifndef INC_PACKET_SV
`define INC_PACKET_SV
class Packet;
    //properties
    rand bit [3:0]          sa, da;
    rand bit [7:0]          payload[$];
    string                  name;
    //constraints
    constraint              constr_addr_scope {
                                sa >= 0 && sa <= 15 && 
                                da >= 0 && da <= 15;
                            };
    constraint              constr_payload_scope {
                                payload.size() inside {[3:6]};
                            }
    //methods                        
    function new(input string name);
        this.name = name;    
    endfunction: new
    
    function bit compare(Packet pkt2cmp, ref string message);
        bit is_same = 1'b1;
        $display("Entering compare function");
        
        // Kiểm tra null
        if (pkt2cmp == null) begin
            message = "Packet to compare is null";
            return 1'b0;
        end
        
        // So sánh destination address (da)
        if (this.da != pkt2cmp.da) begin
            is_same = 1'b0;
            message = $sformatf("Destination address differ: %0d vs %0d", this.da, pkt2cmp.da);
            return is_same;
        end
        
        // So sánh payload
        if (this.payload.size() != pkt2cmp.payload.size()) begin
            is_same = 1'b0;
            message = $sformatf("Payload size differ: %0d vs %0d", this.payload.size(), pkt2cmp.payload.size());
            return is_same;     
        end
        else begin
            foreach(this.payload[i]) begin
                if(this.payload[i] != pkt2cmp.payload[i]) begin
                    is_same = 1'b0;
                    message = $sformatf("Payload differ at index %0d: %h (%b) vs %h (%b)", i, this.payload[i], this.payload[i], pkt2cmp.payload[i], pkt2cmp.payload[i]);
                    return is_same;
                end
            end
        end
        
        if (is_same) begin
            message = "Packets are identical";
        end
        $display("Exiting compare function");
        return is_same;
    endfunction
    
    function void display(input string prefix = "PACKET");
        $display("Packet display() note: ", prefix);
        $display("sa = %d, da = %d", this.sa, this.da);
        foreach(payload[i]) begin
            $display("payload[%0d] = %h (%b)", i, payload[i], payload[i]); 
        end
    endfunction
    
    function void setPacket(input int sa, input int da, input bit[7:0] payload[$]);
        this.sa         = sa;
        this.da         = da;
        this.payload    = payload;
    endfunction
endclass: Packet    
`endif
//test bench
//module packet_tb();
//    initial begin
//        string message;
//        Packet pkt1[10];
//        Packet pktcmp;
//        pktcmp = new ("test");
//        foreach(pkt1[i]) begin
//            pkt1[i] = new($sformatf("pkt%0d", i));
//            if(!pkt1[i].randomize()) begin
//                $finish;
//            end
//            else begin
//                if(pkt1[i].compare(pktcmp, message)) begin
//                    $display("equal - compare = %b - %s", pkt1[i].compare(pktcmp, message), message);
//                end
//                else begin
//                    $display("not equal - compare = %b - %s", pkt1[i].compare(pktcmp, message), message);
//                end
//            end
//        end  
//    end
//endmodule
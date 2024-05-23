`timescale 1ns / 1ps
program automatic test(router_io.tb rtr_io);
    bit     [3:0]   sa1, sa2, sa3, da1, da2, da3;
    logic   [7:0]   payload_queue[$];
    bit     [7:0]   temp1, temp3, temp4, temp5;
    bit             temp2[$];
    bit     [7:0]   payload[$];
    bit     [7:0]   pkt2cmp_payload[$];
    integer         i, j;
    initial begin
                reset();
                gen1();  
        fork
                send();
                recv();
        join
                check();
    end
    task reset();
        rtr_io.reset_n      = 1'b0;
        rtr_io.cb.frame_n   <= 16'hffff;
        rtr_io.cb.valid_n   <= ~('b0);
        ##2 
        rtr_io.cb.reset_n   <= 1'b1;
        repeat (15) @(rtr_io.cb);   
    endtask
    
    task gen1();
        sa1 = 3;
        da1 = 7;
        sa2 = 4;
        da2 = 8;
        sa3 = 5;
        da3 = 8;
        for (i = 0; i < 21; i = i + 1) begin
            payload_queue.push_back($random);
            $display(" i = %0d, random = %0h", i, payload_queue[i]);
        end
    endtask
    task send();
        rtr_io.cb.frame_n[sa1] <= 1'b0;        
        rtr_io.cb.frame_n[sa2] <= 1'b0;        
        rtr_io.cb.frame_n[sa3] <= 1'b0;

        send_addrs();
        send_padding();
        send_payload();
    endtask
    task send_addrs(); 
        rtr_io.cb.din[sa1] <= da1[3];
        rtr_io.cb.din[sa2] <= da2[3];
        rtr_io.cb.din[sa3] <= da3[3];
        #20 
        rtr_io.cb.din[sa1] <= da1[2];
        rtr_io.cb.din[sa2] <= da2[2];
        rtr_io.cb.din[sa3] <= da3[2];
        #20 
        rtr_io.cb.din[sa1] <= da1[1];
        rtr_io.cb.din[sa2] <= da2[1];
        rtr_io.cb.din[sa3] <= da3[1];
        #20 
        rtr_io.cb.din[sa1] <= da1[0];
        rtr_io.cb.din[sa2] <= da2[0];
        rtr_io.cb.din[sa3] <= da3[0];
    endtask
    task send_padding();
        #20
        rtr_io.cb.din[sa1] <= 1'bx;
        rtr_io.cb.din[sa2] <= 1'bx;
        rtr_io.cb.din[sa3] <= 1'bx;
        #20
        rtr_io.cb.din[sa1] <= 1'bx;
        rtr_io.cb.din[sa2] <= 1'bx;
        rtr_io.cb.din[sa3] <= 1'bx;
    endtask
    task send_payload();
        for(i = 0; i <= payload_queue.size(); i = i + 1) begin
            temp1 = payload_queue.pop_back();
            payload.push_front(temp1); //for self-check
            for(j = 0; j < 8; j = j + 1) begin
                #20 
                rtr_io.cb.din[sa1]      <= temp1[j];
                rtr_io.cb.valid_n[sa1]  <= 1'b0;
                
                rtr_io.cb.din[sa2]      <= $random;
                rtr_io.cb.valid_n[sa2]  <= 1'b0;
                
                rtr_io.cb.din[sa3]      <= ~$random;
                rtr_io.cb.valid_n[sa3]  <= 1'b0;
            end
            if(i == 3) begin
                rtr_io.cb.frame_n[sa1] <= 1'b1;
                rtr_io.cb.valid_n[sa1] <= 1'b1;
                
                rtr_io.cb.frame_n[sa2] <= 1'b1;
                rtr_io.cb.valid_n[sa2] <= 1'b1;
            end
            else if (i == 5) begin
                rtr_io.cb.frame_n[sa3] <= 1'b1;
                rtr_io.cb.valid_n[sa3] <= 1'b1;
            end
            else if (i > 8)
                break;
        end
    endtask
    
    task recv();
        @(negedge rtr_io.cb.frameo_n[da1]);                       
        get_payload(); 
    endtask
    task get_payload();
        
        @(negedge rtr_io.cb.valido_n[da1]);
        while(!rtr_io.cb.frameo_n[da1]) begin
            if(!rtr_io.cb.valido_n[da1]) begin
                temp2.push_front(rtr_io.cb.dout[da1]);
                #20;                            //get payload every 20ns
            end
            else
                #20;                            //skip this cycle if valido_n is high
        end
        temp2.push_front(rtr_io.cb.dout[da1]);  //get last bit after posedge valido_n
        while(temp2.size()) begin
            for(i = 0; i < 8; i = i + 1) 
                temp5 = {temp2.pop_back(), temp5[7:1]};
            pkt2cmp_payload.push_front(temp5);
        end
    endtask
    
    task check();
        compare();
    endtask
    task compare();
        while (pkt2cmp_payload.size()) begin
            temp3 = payload.pop_back();
            temp4 = pkt2cmp_payload.pop_back();
            if(temp3 == temp4)
                $display ("Port3 => Port7 : Transfer successed [din = %0h, dout = %0h]", temp3, temp4);
            else begin
                $display ("Port3 => Port7 : Transfer failed    [din = %0h, dout = %0h]", temp3, temp4);
                break;
            end
        end
    endtask
endprogram: test

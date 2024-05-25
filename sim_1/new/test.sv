`timescale 1ns / 1ps
program automatic test(router_io.tb rtr_io);
    bit     [3:0]   sa, da;
    logic   [7:0]   payload_queue[$];
    bit     [7:0]   temp1, temp3, temp4, temp5;
    bit             temp2[$];
    bit     [7:0]   payload[$];
    bit     [7:0]   pkt2cmp_payload[$];
    integer         i, j;
    
    initial begin
       testcase1();     //port3     => port7
       #100
//       testcase2();     //16port    => 16port
//       #100
//       testcase3();     //16port    => port8
//       #100
       testcase4();
    end
    
    task testcase1();
        sa = 3;
        da = 7;
        reset();
        gen();  
        fork
            send1();
            recv1();
        join
            check();
    endtask
    
    task testcase2();
        send2();
    endtask
        
    task testcase3();
        send3();
    endtask
    
    task testcase4();
        send4();
    endtask
    
    task reset();
        rtr_io.reset_n      = 1'b0;
        rtr_io.cb.frame_n   <= 16'hffff;
        rtr_io.cb.valid_n   <= ~('b0);
        ##2
        rtr_io.cb.reset_n   <= 1'b1;
        repeat (15) @(rtr_io.cb);   
    endtask
    
    task gen();
        for (i = 0; i < 32; i = i + 1) begin
            payload_queue.push_back($random);
            $display(" i = %0d, random = %0h", i, payload_queue[i]);
        end
    endtask
    
    //TESTCASE 1: 1 PORT IN => 1 PORT OUT    (PORT3 => PORT7)
    task send1();
        rtr_io.cb.frame_n[sa] <= 1'b0;        
        send_addrs1  ();
        send_padding1();
        send_payload1();
    endtask
    
    task send_addrs1(); 
        rtr_io.cb.din[sa] <= da[3];
        #20 
        rtr_io.cb.din[sa] <= da[2];
        #20 
        rtr_io.cb.din[sa] <= da[1];
        #20 
        rtr_io.cb.din[sa] <= da[0];
    endtask
    
    task send_padding1();
        #20
        rtr_io.cb.din[sa] <= 1'bx;
        #20
        rtr_io.cb.din[sa] <= 1'bx;
    endtask
    
    task send_payload1();
        if(payload_queue.size()) begin
            for(i = 0; i < 3; i = i + 1) begin //send1 3 bytes
                temp1 = payload_queue.pop_back();
                $display("send data = %h", temp1);
                payload.push_front(temp1); //for self-check
                for(j = 0; j < 8; j = j + 1) begin
                    #20 
                    rtr_io.cb.din[sa]      <= temp1[j];
                    rtr_io.cb.valid_n[sa]  <= 1'b0;
                end
            end
            rtr_io.cb.frame_n[sa] <= 1'b1;
            rtr_io.cb.valid_n[sa] <= 1'b1;
        end
        else
            $display("[ERROR] send_payload: EMPTY QUEUE");
    endtask
    
    task recv1();
        @(negedge rtr_io.cb.frameo_n[da]); 
        get_payload(); 
    endtask
    
    task get_payload();
        @(negedge rtr_io.cb.valido_n[da]);
        while(!rtr_io.cb.frameo_n[da]) begin
            if(!rtr_io.cb.valido_n[da]) begin
                temp2.push_front(rtr_io.cb.dout[da]);
                #20;                            //get payload every 20ns
            end
            else
                #20;                            //skip this cycle if valido_n is high
        end
        temp2.push_front(rtr_io.cb.dout[da]);  //get last bit after posedge valido_n
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
                $display ("Transfer successed [din = %0h, dout = %0h]", temp3, temp4);
            else begin
                $display ("Transfer failed    [din = %0h, dout = %0h]", temp3, temp4);
                break;
            end
        end
    endtask
    //TESTCASE 2: 16 PORT_IN => 16 PORT_OUT
    task send2();
        rtr_io.cb.frame_n <= 16'h0000;        
        send_addrs2  ();
        send_padding2();
        send_payload2();
    endtask
    task send_addrs2(); 
        rtr_io.cb.din <= 16'b1000000001111111;
        #20 
        rtr_io.cb.din <= 16'b0111100000001111;
        #20 
        rtr_io.cb.din <= 16'b0110011000110011;
        #20 
        rtr_io.cb.din <= 16'b0101010101010101;
    endtask
    task send_padding2();
        #20
        rtr_io.cb.din <= 16'bx;
        #20
        rtr_io.cb.din <= 16'bx;
    endtask
    task send_payload2();
        for(i = 0; i < 24; i = i + 1) begin //send1 3 bytes
            #20 
            rtr_io.cb.din       <= $random;
            rtr_io.cb.valid_n   <= 16'h0000;
        end
        rtr_io.cb.frame_n   <= 16'hffff;
        rtr_io.cb.valid_n   <= 16'hffff;
    endtask
    //TESTCASE 3: 16 PORT IN => 1 PORT OUT (ALL PORT => PORT 10)
    task send3();
        rtr_io.cb.frame_n <= 16'h0000;        
        send_addrs3  ();
        send_padding3();
        send_payload3();
    endtask
    task send_addrs3(); 
        //portout address = 1000 = port 8
        rtr_io.cb.din <= 16'hffff; 
        #20 
        rtr_io.cb.din <= 16'h0000;
        #20 
        rtr_io.cb.din <= 16'h0000;
        #20 
        rtr_io.cb.din <= 16'h0000;
    endtask
    task send_padding3();
        #20
        rtr_io.cb.din <= 16'bx;
        #20
        rtr_io.cb.din <= 16'bx;
    endtask
    task send_payload3();
        for(i = 0; i < 80; i = i + 1) begin //send 10 bytes
            #20 
            rtr_io.cb.din       <= $random;
            rtr_io.cb.valid_n   <= 16'h0000;
            if(i == 7) begin
                rtr_io.cb.frame_n[0]    <= 1'b1;    //end port0
                rtr_io.cb.valid_n[0]    <= 1'b1;    
            end
            if(i == 15) begin
                rtr_io.cb.frame_n[1]    <= 1'b1;    //end port1
                rtr_io.cb.valid_n[1]    <= 1'b1;    
            end
            if(i == 23) begin
                rtr_io.cb.frame_n[3]    <= 1'b1;    //end port3 - unaffect
                rtr_io.cb.valid_n[3]    <= 1'b1;    
            end
            if(i == 31) begin
                rtr_io.cb.frame_n[2]    <= 1'b1;    //end port2
                rtr_io.cb.valid_n[2]    <= 1'b1;    
            end
        end
        rtr_io.cb.frame_n   <= 16'hffff;
        rtr_io.cb.valid_n   <= 16'hffff;
    endtask
    //TESTCASE 4: 
    task send4();
        rtr_io.cb.frame_n <= 16'hffff0;        
        send_addrs4  ();
        send_padding4();
        send_payload4();
    endtask
    task send_addrs4(); 
        // port0 => port 15;
        // port1 => port 14;
        // port2 => port 14;
        // port3 => port 14;
        rtr_io.cb.din[3:0] <= 4'b1111; 
        #20 
        rtr_io.cb.din[3:0] <= 4'b1111;
        #20 
        rtr_io.cb.din[3:0] <= 4'b1111;
        #20 
        rtr_io.cb.din[3:0] <= 4'b0001;
    endtask
    task send_padding4();
        #20
        rtr_io.cb.din[3:0] <= 4'bx;
        #20
        rtr_io.cb.din[3:0] <= 4'bx;
    endtask
    task send_payload4();
        for(i = 0; i < 40; i = i + 1) begin //send 10 bytes
            #20 
            rtr_io.cb.din[3:0]      <= $random;
            rtr_io.cb.valid_n[3:0]  <= 4'b0;
            if(i == 7) begin
                rtr_io.cb.frame_n[1]    <= 1'b1;    //end port0
                rtr_io.cb.valid_n[1]    <= 1'b1;    
            end
            if(i == 15) begin
                rtr_io.cb.frame_n[2]    <= 1'b1;    //end port1
                rtr_io.cb.valid_n[2]    <= 1'b1;    
            end
            if(i == 23) begin
                rtr_io.cb.frame_n[3]    <= 1'b1;    //end port3 - unaffect
                rtr_io.cb.valid_n[3]    <= 1'b1;    
            end
        end
        rtr_io.cb.frame_n   <= 16'hffff;
        rtr_io.cb.valid_n   <= 16'hffff;
    endtask
endprogram: test

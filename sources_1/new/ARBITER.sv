`timescale 1ns / 1ps
module ARBITER(reset_n, request, grant, busy);
    input bit           reset_n;
    input bit [15:0]    request;
    
    output logic [15:0] grant;
    output bit          busy;
    
    reg                 higherRequests;
    wire                noGrant;
    integer i;
    
    assign noGrant  = ~|grant[15:0];
    assign busy     = !noGrant;
    
    always_ff @(negedge reset_n) begin
        if(!reset_n) begin
            grant   <= 16'b0;
            busy    <= 1'b0;
        end
    end
    
    always_comb begin
       for(i = 0; i < 16; i = i + 1) begin
            case(i)
                0:    higherRequests = 1'b0;
                1:    higherRequests = request[0];
                2:    higherRequests = |request[1:0];
                3:    higherRequests = |request[2:0];
                4:    higherRequests = |request[3:0];
                5:    higherRequests = |request[4:0];
                6:    higherRequests = |request[5:0];
                7:    higherRequests = |request[6:0];
                8:    higherRequests = |request[7:0];
                9:    higherRequests = |request[8:0];
                10:   higherRequests = |request[9:0];
                11:   higherRequests = |request[10:0];
                12:   higherRequests = |request[11:0];
                13:   higherRequests = |request[12:0];
                14:   higherRequests = |request[13:0];
                15:   higherRequests = |request[14:0];
            endcase
            if (!reset_n)
                grant   <= 16'b0;
            else if (noGrant)
                    grant[i] = request[i] & ~higherRequests;
            else if (!noGrant && !higherRequests && (i != 0))
                    grant[i] = request[i];
            else
                    grant[i] = request[i] & grant[i];
       end
    end    
endmodule 
   
//testbench
//module arbiter_tb();
//    reg           reset_n;
//    reg [15:0]    request;
//    wire [15:0]   grant;
//    wire          busy;
//    ARBITER dut(reset_n, request, grant, busy);
    
//    initial begin
//        reset_n <= 1'b1;
//        request <= 16'b0;
//        #5
//        reset_n <= 1'b0;
//        #20
//        reset_n <= 1'b1;
//        #50
//        request <= 16'h000f;
//        #20
//        request[0] <= 1'b0;
//        #5
//        request[1] <= 1'b0;
//        #10
//        request[2] <= 1'b0;
//        #20
//        request[3] <= 1'b0;
//        #10
//        request[0] <= 1'b1;
//        request[2] <= 1'b1;
//        #15
//        request[3] <= 1'b0;
//        #10
//        request[0] <= 1'b0;
//        #40
//        request <= 16'hffff;
//        #15
//        reset_n <= 1'b0;
//    end
//endmodule

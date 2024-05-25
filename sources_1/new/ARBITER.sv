`timescale 1ns / 1ps
module ARBITER(reset_n, request, grant, busy);
    input bit           reset_n;
    input bit [15:0]    request;
    
    output reg [15:0]   grant;
    output bit          busy;
    
    reg                 higherRequestsPriority;
    wire                noGrant;
   
    assign noGrant  = ~|grant[15:0];
    assign busy     = !noGrant;
    
    integer i;
    always @(*) begin
        if(!reset_n) 
            grant[0] <= 0;         
        else if(noGrant) 
            grant[0] <= request[0];
        else
            grant[0] <= request[0] & grant[0];
       for(i = 1; i < 16; i = i + 1) begin
            case(i)
                1: higherRequestsPriority = request[0];
                2: higherRequestsPriority = |request[1:0];
                3: higherRequestsPriority = |request[2:0];
                4: higherRequestsPriority = |request[3:0];
                5: higherRequestsPriority = |request[4:0];
                6: higherRequestsPriority = |request[5:0];
                7: higherRequestsPriority = |request[6:0];
                8: higherRequestsPriority = |request[7:0];
                9: higherRequestsPriority = |request[8:0];
                10: higherRequestsPriority = |request[9:0];
                11: higherRequestsPriority = |request[10:0];
                12: higherRequestsPriority = |request[11:0];
                13: higherRequestsPriority = |request[12:0];
                14: higherRequestsPriority = |request[13:0];
                15: higherRequestsPriority = |request[14:0];
            endcase
            if(!reset_n)
                    grant[i] <= 0;   
            else if (noGrant)
                    grant[i] <= request[i] & ~higherRequestsPriority;
            else if (!noGrant && !higherRequestsPriority)
                    grant[i] <= request[i];
            else
                    grant[i] <= request[i] & grant[i];
       end
       higherRequestsPriority = 0;
    end                  
endmodule

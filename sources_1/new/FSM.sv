`timescale 1ns / 1ps
module FSM(clk, reset_n, din, frame_n, busy16_in, grant16_in, request_out, data_enable_out, address_out);
    input   bit             clk;
    input   bit             reset_n;
    input   logic           din;
    input   bit             frame_n;
    input   bit [15:0]      busy16_in;
    input   bit [15:0]      grant16_in;
    
    output  bit [15:0]      request_out;
    output  bit             data_enable_out;
    output  logic [3:0]     address_out;
    
    reg [2:0]   currentState;
    reg [2:0]   nextState;
    reg [3:0]   addr;
    reg [1:0]   frame_n_count;
    parameter   initState           = 3'b000;
    parameter   getAddr1State       = 3'b001;
    parameter   getAddr2State       = 3'b010;
    parameter   getAddr3State       = 3'b011;
    parameter   getAddr4State       = 3'b100;
    parameter   paddingState        = 3'b101;
    parameter   payloadState        = 3'b110;
    
    //next state block
    always_comb begin
        case(currentState)
            initState: begin
                if(!frame_n)
                    nextState = getAddr1State;
                else
                    nextState = initState;
            end
            getAddr1State: 
                    nextState = getAddr2State;
            
            getAddr2State: 
                    nextState = getAddr3State;
            
            getAddr3State: 
                    nextState = getAddr4State;
            
            getAddr4State: begin
                if(grant16_in[addr])
                    nextState = payloadState;
                else
                    nextState = paddingState;
            end
            paddingState: begin
                if(grant16_in[addr])
                    nextState = payloadState;
                else
                    nextState = paddingState;
            end
            payloadState: begin
                if(frame_n) begin
                    if(frame_n_count >= 1)
                        nextState = initState;
                    else
                        nextState = payloadState;
                end
                else
                    nextState = payloadState;
            end
            default:
                    nextState = initState;
        endcase
    end
    
    //state memory block
    always_ff @(posedge clk or negedge reset_n) begin  
        if(!reset_n) begin
            currentState    <= initState;
            frame_n_count   <= 2'b00;
        end
        else begin
            currentState    <= nextState;
            if(currentState == payloadState) begin
                if(frame_n)
                    frame_n_count <= frame_n_count + 1;
                else
                    frame_n_count <= 2'b00;
            end
            else
                frame_n_count <= 2'b00;
        end
    end
    
    //output block
    always_comb begin
        case(currentState)
            initState: begin
                data_enable_out     = 1'b0;
                request_out         = 16'b0;
                address_out         = 4'bx;
                addr  = 4'bx;
            end
            getAddr1State: begin
                data_enable_out     = 1'b0;
                request_out         = 16'b0;
                address_out         = 4'bx;
            end
            getAddr2State: begin
                data_enable_out     = 1'b0;
                request_out         = 16'b0;
                address_out         = 4'bx;
            end
            getAddr3State: begin
                data_enable_out     = 1'b0;
                request_out         = 16'b0;
                address_out         = 4'bx;
            end
            getAddr4State: begin
                data_enable_out     = 1'b0;
                request_out[addr]   = 1'b1;
                address_out         = addr;
            end
            paddingState: begin
                data_enable_out     = 1'b0;
                request_out[addr]   = 1'b1;
                address_out         = addr;
            end
            payloadState: begin
                data_enable_out     = 1'b1;
                request_out[addr]   = 1'b1;
                address_out         = addr;
            end
            default: begin
                data_enable_out     = 1'b0;
                request_out         = 16'b0;
                address_out         = 4'bx;
                addr                = 4'bx;
            end
        endcase
    end
    always @(posedge clk) begin
        case(currentState)
            initState:      addr[3] <= din;
            getAddr1State:  addr[2] <= din;
            getAddr2State:  addr[1] <= din;
            getAddr3State:  addr[0] <= din;
        endcase
    end
endmodule

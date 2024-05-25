`timescale 1ns / 1ps
module DATA_ENABLE(data_enable, din, valid_n, frame_n, dout, valido_n, frameo_n);
    input bit       data_enable;
    input logic     din;
    input logic     valid_n;
    input bit       frame_n;
    
    output logic    dout;
    output logic    valido_n;
    output logic    frameo_n;
    
    always @(*) begin
        if(data_enable) begin
            dout     <= din;
            valido_n <= valid_n;
            frameo_n <= frame_n;
        end
        else begin
            dout     <= 1'bx;
            valido_n <= 1'b1;
            frameo_n <= 1'b1;
        end  
    end
    
endmodule

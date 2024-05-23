`timescale 1ns / 1ps
module router(clk, reset_n, din, valid_n, frame_n, dout, valido_n, frameo_n);
    input bit           clk;
    input bit           reset_n;
    input logic [15:0]  din;
    input logic [15:0]  valid_n;
    input bit   [15:0]  frame_n;

    output logic    [15:0]  dout;
    output logic    [15:0]  valido_n;
    output bit      [15:0]  frameo_n;
    
    initial begin
            dout        <= 16'bxxxx;
            valido_n    <= 16'hffff;
            frameo_n    <= 16'hffff;
        //end
    end
    logic [15:0]    logic_request_abt0, logic_request_abt1, logic_request_abt2, logic_request_abt3,
                    logic_request_abt4, logic_request_abt5, logic_request_abt6, logic_request_abt7, 
                    logic_request_abt8, logic_request_abt9, logic_request_abt10, logic_request_abt11, 
                    logic_request_abt12, logic_request_abt13, logic_request_abt14, logic_request_abt15;
                    
    logic [15:0]    logic_grant_abt0, logic_grant_abt1, logic_grant_abt2, logic_grant_abt3,
                    logic_grant_abt4, logic_grant_abt5, logic_grant_abt6, logic_grant_abt7, 
                    logic_grant_abt8, logic_grant_abt9, logic_grant_abt10, logic_grant_abt11, 
                    logic_grant_abt12, logic_grant_abt13, logic_grant_abt14, logic_grant_abt15;
                    
    logic [15:0]    logic_grant_abt_fsm0, logic_grant_abt_fsm1, logic_grant_abt_fsm2, logic_grant_abt_fsm3, 
                    logic_grant_abt_fsm4, logic_grant_abt_fsm5, logic_grant_abt_fsm6, logic_grant_abt_fsm7, 
                    logic_grant_abt_fsm8, logic_grant_abt_fsm9, logic_grant_abt_fsm10, logic_grant_abt_fsm11, 
                    logic_grant_abt_fsm12, logic_grant_abt_fsm13, logic_grant_abt_fsm14, logic_grant_abt_fsm15;
                    
    logic [3:0]     address0, address1, address2, address3, 
                    address4, address5, address6, address7, 
                    address8, address9, address10, address11, 
                    address12, address13, address14, address15;

    logic [15:0]    grant16_in0, grant16_in1, grant16_in2, grant16_in3, 
                    grant16_in4, grant16_in5, grant16_in6, grant16_in7, 
                    grant16_in8, grant16_in9, grant16_in10, grant16_in11, 
                    grant16_in12, grant16_in13, grant16_in14, grant16_in15;

    wire [15:0]     req0, req1, req2, req3, req4, req5, req6, req7, 
                    req8, req9, req10, req11, req12, req13, req14, req15;
    wire            de0, de1, de2, de3, de4, de5, de6, de7, 
                    de8, de9, de10, de11, de12, de13, de14, de15;
    wire            dout0, dout1, dout2, dout3, dout4, dout5, dout6, dout7,
                    dout8, dout9, dout10, dout11, dout12, dout13, dout14, dout15;
    wire            valido_n0, valido_n1, valido_n2, valido_n3,
                    valido_n4, valido_n5, valido_n6, valido_n7,
                    valido_n8, valido_n9, valido_n10, valido_n11,
                    valido_n12, valido_n13, valido_n14, valido_n15;
    wire            frameo_n0, frameo_n1, frameo_n2, frameo_n3,
                    frameo_n4, frameo_n5, frameo_n6, frameo_n7,
                    frameo_n8, frameo_n9, frameo_n10, frameo_n11,
                    frameo_n12, frameo_n13, frameo_n14, frameo_n15;
    wire [15:0]     busy16_in;
    
    FSM fsm0(clk, reset_n, din[0], frame_n[0], busy16_in, grant16_in0, req0, de0, address0);
    FSM fsm1(clk, reset_n, din[1], frame_n[1], busy16_in, grant16_in1, req1, de1, address1);
    FSM fsm2(clk, reset_n, din[2], frame_n[2], busy16_in, grant16_in2, req2, de2, address2);
    FSM fsm3(clk, reset_n, din[3], frame_n[3], busy16_in, grant16_in3, req3, de3, address3);
    FSM fsm4(clk, reset_n, din[4], frame_n[4], busy16_in, grant16_in4, req4, de4, address4);
    FSM fsm5(clk, reset_n, din[5], frame_n[5], busy16_in, grant16_in5, req5, de5, address5);
    FSM fsm6(clk, reset_n, din[6], frame_n[6], busy16_in, grant16_in6, req6, de6, address6);
    FSM fsm7(clk, reset_n, din[7], frame_n[7], busy16_in, grant16_in7, req7, de7, address7);
    FSM fsm8(clk, reset_n, din[8], frame_n[8], busy16_in, grant16_in8, req8, de8, address8);
    FSM fsm9(clk, reset_n, din[9], frame_n[9], busy16_in, grant16_in9, req9, de9, address9);
    FSM fsm10(clk, reset_n, din[10], frame_n[10], busy16_in, grant16_in10, req10, de10, address10);
    FSM fsm11(clk, reset_n, din[11], frame_n[11], busy16_in, grant16_in11, req11, de11, address11);
    FSM fsm12(clk, reset_n, din[12], frame_n[12], busy16_in, grant16_in12, req12, de12, address12);
    FSM fsm13(clk, reset_n, din[13], frame_n[13], busy16_in, grant16_in13, req13, de13, address13);
    FSM fsm14(clk, reset_n, din[14], frame_n[14], busy16_in, grant16_in14, req14, de14, address14);
    FSM fsm15(clk, reset_n, din[15], frame_n[15], busy16_in, grant16_in15, req15, de15, address15);
    ARBITER abt0(clk, reset_n, logic_request_abt0, logic_grant_abt0, busy_abt0);  
    ARBITER abt1(clk, reset_n, logic_request_abt1, logic_grant_abt1, busy_abt1);
    ARBITER abt2(clk, reset_n, logic_request_abt2, logic_grant_abt2, busy_abt2);
    ARBITER abt3(clk, reset_n, logic_request_abt3, logic_grant_abt3, busy_abt3);
    ARBITER abt4(clk, reset_n, logic_request_abt4, logic_grant_abt4, busy_abt4);
    ARBITER abt5(clk, reset_n, logic_request_abt5, logic_grant_abt5, busy_abt5);
    ARBITER abt6(clk, reset_n, logic_request_abt6, logic_grant_abt6, busy_abt6);
    ARBITER abt7(clk, reset_n, logic_request_abt7, logic_grant_abt7, busy_abt7);
    ARBITER abt8(clk, reset_n, logic_request_abt8, logic_grant_abt8, busy_abt8);
    ARBITER abt9(clk, reset_n, logic_request_abt9, logic_grant_abt9, busy_abt9);
    ARBITER abt10(clk, reset_n, logic_request_abt10, logic_grant_abt10, busy_abt10);
    ARBITER abt11(clk, reset_n, logic_request_abt11, logic_grant_abt11, busy_abt11);
    ARBITER abt12(clk, reset_n, logic_request_abt12, logic_grant_abt12, busy_abt12);
    ARBITER abt13(clk, reset_n, logic_request_abt13, logic_grant_abt13, busy_abt13);
    ARBITER abt14(clk, reset_n, logic_request_abt14, logic_grant_abt14, busy_abt14);
    ARBITER abt15(clk, reset_n, logic_request_abt15, logic_grant_abt15, busy_abt15);
    DATA_ENABLE dataE0(de0, din[0], valid_n[0], frame_n[0], dout0, valido_n0, frameo_n0);
    DATA_ENABLE dataE1(de1, din[1], valid_n[1], frame_n[1], dout1, valido_n1, frameo_n1);
    DATA_ENABLE dataE2(de2, din[2], valid_n[2], frame_n[2], dout2, valido_n2, frameo_n2);
    DATA_ENABLE dataE3(de3, din[3], valid_n[3], frame_n[3], dout3, valido_n3, frameo_n3);
    DATA_ENABLE dataE4(de4, din[4], valid_n[4], frame_n[4], dout4, valido_n4, frameo_n4);
    DATA_ENABLE dataE5(de5, din[5], valid_n[5], frame_n[5], dout5, valido_n5, frameo_n5);
    DATA_ENABLE dataE6(de6, din[6], valid_n[6], frame_n[6], dout6, valido_n6, frameo_n6);
    DATA_ENABLE dataE7(de7, din[7], valid_n[7], frame_n[7], dout7, valido_n7, frameo_n7);
    DATA_ENABLE dataE8(de8, din[8], valid_n[8], frame_n[8], dout8, valido_n8, frameo_n8);
    DATA_ENABLE dataE9(de9, din[9], valid_n[9], frame_n[9], dout9, valido_n9, frameo_n9);
    DATA_ENABLE dataE10(de10, din[10], valid_n[10], frame_n[10], dout10, valido_n10, frameo_n10);
    DATA_ENABLE dataE11(de11, din[11], valid_n[11], frame_n[11], dout11, valido_n11, frameo_n11);
    DATA_ENABLE dataE12(de12, din[12], valid_n[12], frame_n[12], dout12, valido_n12, frameo_n12);
    DATA_ENABLE dataE13(de13, din[13], valid_n[13], frame_n[13], dout13, valido_n13, frameo_n13);
    DATA_ENABLE dataE14(de14, din[14], valid_n[14], frame_n[14], dout14, valido_n14, frameo_n14);
    DATA_ENABLE dataE15(de15, din[15], valid_n[15], frame_n[15], dout15, valido_n15, frameo_n15);
    assign grant16_in0 = {logic_grant_abt15[0], logic_grant_abt14[0], logic_grant_abt13[0], logic_grant_abt12[0], logic_grant_abt11[0], logic_grant_abt10[0],
                         logic_grant_abt9[0], logic_grant_abt8[0], logic_grant_abt7[0], logic_grant_abt6[0], logic_grant_abt5[0],
                         logic_grant_abt4[0], logic_grant_abt3[0], logic_grant_abt2[0], logic_grant_abt1[0], logic_grant_abt0[0]};
    assign grant16_in1 = {logic_grant_abt15[1], logic_grant_abt14[1], logic_grant_abt13[1], logic_grant_abt12[1], logic_grant_abt11[1], logic_grant_abt10[1],
                         logic_grant_abt9[1], logic_grant_abt8[1], logic_grant_abt7[1], logic_grant_abt6[1], logic_grant_abt5[1],
                         logic_grant_abt4[1], logic_grant_abt3[1], logic_grant_abt2[1], logic_grant_abt1[1], logic_grant_abt0[1]};
    assign grant16_in2 = {logic_grant_abt15[2], logic_grant_abt14[2], logic_grant_abt13[2], logic_grant_abt12[2], logic_grant_abt11[2], logic_grant_abt10[2],
                         logic_grant_abt9[2], logic_grant_abt8[2], logic_grant_abt7[2], logic_grant_abt6[2], logic_grant_abt5[2],
                         logic_grant_abt4[2], logic_grant_abt3[2], logic_grant_abt2[2], logic_grant_abt1[2], logic_grant_abt0[2]};
    assign grant16_in3 = {logic_grant_abt15[3], logic_grant_abt14[3], logic_grant_abt13[3], logic_grant_abt12[3], logic_grant_abt11[3], logic_grant_abt10[3],
                         logic_grant_abt9[3], logic_grant_abt8[3], logic_grant_abt7[3], logic_grant_abt6[3], logic_grant_abt5[3],
                         logic_grant_abt4[3], logic_grant_abt3[3], logic_grant_abt2[3], logic_grant_abt1[3], logic_grant_abt0[3]};
    assign grant16_in4 = {logic_grant_abt15[4], logic_grant_abt14[4], logic_grant_abt13[4], logic_grant_abt12[4], logic_grant_abt11[4], logic_grant_abt10[4],
                         logic_grant_abt9[4], logic_grant_abt8[4], logic_grant_abt7[4], logic_grant_abt6[4], logic_grant_abt5[4],
                         logic_grant_abt4[4], logic_grant_abt3[4], logic_grant_abt2[4], logic_grant_abt1[4], logic_grant_abt0[4]};
    assign grant16_in5 = {logic_grant_abt15[5], logic_grant_abt14[5], logic_grant_abt13[5], logic_grant_abt12[5], logic_grant_abt11[5], logic_grant_abt10[5],
                         logic_grant_abt9[5], logic_grant_abt8[5], logic_grant_abt7[5], logic_grant_abt6[5], logic_grant_abt5[5],
                         logic_grant_abt4[5], logic_grant_abt3[5], logic_grant_abt2[5], logic_grant_abt1[5], logic_grant_abt0[5]};
    assign grant16_in6 = {logic_grant_abt15[6], logic_grant_abt14[6], logic_grant_abt13[6], logic_grant_abt12[6], logic_grant_abt11[6], logic_grant_abt10[6],
                         logic_grant_abt9[6], logic_grant_abt8[6], logic_grant_abt7[6], logic_grant_abt6[6], logic_grant_abt5[6],
                         logic_grant_abt4[6], logic_grant_abt3[6], logic_grant_abt2[6], logic_grant_abt1[6], logic_grant_abt0[6]};
    assign grant16_in7 = {logic_grant_abt15[7], logic_grant_abt14[7], logic_grant_abt13[7], logic_grant_abt12[7], logic_grant_abt11[7], logic_grant_abt10[7],
                         logic_grant_abt9[7], logic_grant_abt8[7], logic_grant_abt7[7], logic_grant_abt6[7], logic_grant_abt5[7],
                         logic_grant_abt4[7], logic_grant_abt3[7], logic_grant_abt2[7], logic_grant_abt1[7], logic_grant_abt0[7]};
    assign grant16_in8 = {logic_grant_abt15[8], logic_grant_abt14[8], logic_grant_abt13[8], logic_grant_abt12[8], logic_grant_abt11[8], logic_grant_abt10[8],
                         logic_grant_abt9[8], logic_grant_abt8[8], logic_grant_abt7[8], logic_grant_abt6[8], logic_grant_abt5[8],
                         logic_grant_abt4[8], logic_grant_abt3[8], logic_grant_abt2[8], logic_grant_abt1[8], logic_grant_abt0[8]};
    assign grant16_in9 = {logic_grant_abt15[9], logic_grant_abt14[9], logic_grant_abt13[9], logic_grant_abt12[9], logic_grant_abt11[9], logic_grant_abt10[9],
                         logic_grant_abt9[9], logic_grant_abt8[9], logic_grant_abt7[9], logic_grant_abt6[9], logic_grant_abt5[9],
                         logic_grant_abt4[9], logic_grant_abt3[9], logic_grant_abt2[9], logic_grant_abt1[9], logic_grant_abt0[9]};
    assign grant16_in10 = {logic_grant_abt15[10], logic_grant_abt14[10], logic_grant_abt13[10], logic_grant_abt12[10], logic_grant_abt11[10], logic_grant_abt10[10],
                         logic_grant_abt9[10], logic_grant_abt8[10], logic_grant_abt7[10], logic_grant_abt6[10], logic_grant_abt5[10],
                         logic_grant_abt4[10], logic_grant_abt3[10], logic_grant_abt2[10], logic_grant_abt1[10], logic_grant_abt0[10]};
    assign grant16_in11 = {logic_grant_abt15[11], logic_grant_abt14[11], logic_grant_abt13[11], logic_grant_abt12[11], logic_grant_abt11[11], logic_grant_abt10[11],
                         logic_grant_abt9[11], logic_grant_abt8[11], logic_grant_abt7[11], logic_grant_abt6[11], logic_grant_abt5[11],
                         logic_grant_abt4[11], logic_grant_abt3[11], logic_grant_abt2[11], logic_grant_abt1[11], logic_grant_abt0[11]};
    assign grant16_in12 = {logic_grant_abt15[12], logic_grant_abt14[12], logic_grant_abt13[12], logic_grant_abt12[12], logic_grant_abt11[12], logic_grant_abt10[12],
                         logic_grant_abt9[12], logic_grant_abt8[12], logic_grant_abt7[12], logic_grant_abt6[12], logic_grant_abt5[12],
                         logic_grant_abt4[12], logic_grant_abt3[12], logic_grant_abt2[12], logic_grant_abt1[12], logic_grant_abt0[12]};
    assign grant16_in13 = {logic_grant_abt15[13], logic_grant_abt14[13], logic_grant_abt13[13], logic_grant_abt12[13], logic_grant_abt11[13], logic_grant_abt10[13],
                         logic_grant_abt9[13], logic_grant_abt8[13], logic_grant_abt7[13], logic_grant_abt6[13], logic_grant_abt5[13],
                         logic_grant_abt4[13], logic_grant_abt3[13], logic_grant_abt2[13], logic_grant_abt1[13], logic_grant_abt0[13]};
    assign grant16_in14 = {logic_grant_abt15[14], logic_grant_abt14[14], logic_grant_abt13[14], logic_grant_abt12[14], logic_grant_abt11[14], logic_grant_abt10[14],
                         logic_grant_abt9[14], logic_grant_abt8[14], logic_grant_abt7[14], logic_grant_abt6[14], logic_grant_abt5[14],
                         logic_grant_abt4[14], logic_grant_abt3[14], logic_grant_abt2[14], logic_grant_abt1[14], logic_grant_abt0[14]};
    assign grant16_in15 = {logic_grant_abt15[15], logic_grant_abt14[15], logic_grant_abt13[15], logic_grant_abt12[15], logic_grant_abt11[15], logic_grant_abt10[15],
                         logic_grant_abt9[15], logic_grant_abt8[15], logic_grant_abt7[15], logic_grant_abt6[15], logic_grant_abt5[15],
                         logic_grant_abt4[15], logic_grant_abt3[15], logic_grant_abt2[15], logic_grant_abt1[15], logic_grant_abt0[15]};
    assign busy16_in    = {busy_abt15, busy_abt14, busy_abt13, busy_abt12, busy_abt11, busy_abt10, busy_abt9, busy_abt8, busy_abt7, busy_abt6, busy_abt5, busy_abt4, 
                          busy_abt3, busy_abt2, busy_abt1, busy_abt0};
    assign logic_request_abt0 = {req15[0], req14[0], req13[0], req12[0], 
                req11[0], req10[0], req9[0], req8[0], 
                req7[0], req6[0], req5[0], req4[0], 
                req3[0], req2[0], req1[0], req0[0]};
    assign logic_request_abt1 = {req15[1], req14[1], req13[1], req12[1], 
                req11[1], req10[1], req9[1], req8[1], 
                req7[1], req6[1], req5[1], req4[1], 
                req3[1], req2[1], req1[1], req0[1]};
    assign logic_request_abt2 = {req15[2], req14[2], req13[2], req12[2], 
                req11[2], req10[2], req9[2], req8[2], 
                req7[2], req6[2], req5[2], req4[2], 
                req3[2], req2[2], req1[2], req0[2]};
    assign logic_request_abt3 = {req15[3], req14[3], req13[3], req12[3], 
                req11[3], req10[3], req9[3], req8[3], 
                req7[3], req6[3], req5[3], req4[3], 
                req3[3], req2[3], req1[3], req0[3]};
    assign logic_request_abt4 = {req15[4], req14[4], req13[4], req12[4], 
                req11[4], req10[4], req9[4], req8[4], 
                req7[4], req6[4], req5[4], req4[4], 
                req3[4], req2[4], req1[4], req0[4]};
    assign logic_request_abt5 = {req15[5], req14[5], req13[5], req12[5], 
                req11[5], req10[5], req9[5], req8[5], 
                req7[5], req6[5], req5[5], req4[5], 
                req3[5], req2[5], req1[5], req0[5]};
    assign logic_request_abt6 = {req15[6], req14[6], req13[6], req12[6], 
                req11[6], req10[6], req9[6], req8[6], 
                req7[6], req6[6], req5[6], req4[6], 
                req3[6], req2[6], req1[6], req0[6]};
    assign logic_request_abt7 = {req15[7], req14[7], req13[7], req12[7], 
                req11[7], req10[7], req9[7], req8[7], 
                req7[7], req6[7], req5[7], req4[7], 
                req3[7], req2[7], req1[7], req0[7]};
    assign logic_request_abt8 = {req15[8], req14[8], req13[8], req12[8], 
                req11[8], req10[8], req9[8], req8[8], 
                req7[8], req6[8], req5[8], req4[8], 
                req3[8], req2[8], req1[8], req0[8]};
    assign logic_request_abt9 = {req15[9], req14[9], req13[9], req12[9], 
                req11[9], req10[9], req9[9], req8[9], 
                req7[9], req6[9], req5[9], req4[9], 
                req3[9], req2[9], req1[9], req0[9]};
    assign logic_request_abt10 = {req15[10], req14[10], req13[10], req12[10], 
                req11[10], req10[10], req9[10], req8[10], 
                req7[10], req6[10], req5[10], req4[10], 
                req3[10], req2[10], req1[10], req0[10]};
    assign logic_request_abt11 = {req15[11], req14[11], req13[11], req12[11], 
                req11[11], req10[11], req9[11], req8[11], 
                req7[11], req6[11], req5[11], req4[11], 
                req3[11], req2[11], req1[11], req0[11]};
    assign logic_request_abt12 = {req15[12], req14[12], req13[12], req12[12], 
                req11[12], req10[12], req9[12], req8[12], 
                req7[12], req6[12], req5[12], req4[12], 
                req3[12], req2[12], req1[12], req0[12]};
    assign logic_request_abt13 = {req15[13], req14[13], req13[13], req12[13], 
                req11[13], req10[13], req9[13], req8[13], 
                req7[13], req6[13], req5[13], req4[13], 
                req3[13], req2[13], req1[13], req0[13]};
    assign logic_request_abt14 = {req15[14], req14[14], req13[14], req12[14], 
                req11[14], req10[14], req9[14], req8[14], 
                req7[14], req6[14], req5[14], req4[14], 
                req3[14], req2[14], req1[14], req0[14]};
    assign logic_request_abt15 = {req15[15], req14[15], req13[15], req12[15], 
                req11[15], req10[15], req9[15], req8[15], 
                req7[15], req6[15], req5[15], req4[15], 
                req3[15], req2[15], req1[15], req0[15]};

    always @(*) begin
        if(de0) begin
        case(address0)
            4'b0000:  begin
                dout[0] = dout0;
                valido_n[0] = valido_n0;
                frameo_n[0] = frameo_n0;
                end
            4'b0001:  begin
                dout[1] = dout0;
                valido_n[1] = valido_n0;
                frameo_n[1] = frameo_n0;
                end
            4'b0010:  begin
                dout[2] = dout0;
                valido_n[2] = valido_n0;
                frameo_n[2] = frameo_n0;
                end
            4'b0011:  begin
                dout[3] = dout0;
                valido_n[3] = valido_n0;
                frameo_n[3] = frameo_n0;
                end
            4'b0100:  begin
                dout[4] = dout0;
                valido_n[4] = valido_n0;
                frameo_n[4] = frameo_n0;
                end
            4'b0101:  begin
                dout[5] = dout0;
                valido_n[5] = valido_n0;
                frameo_n[5] = frameo_n0;
                end
            4'b0110:  begin
                dout[6] = dout0;
                valido_n[6] = valido_n0;
                frameo_n[6] = frameo_n0;
                end
            4'b0111:  begin
                dout[7] = dout0;
                valido_n[7] = valido_n0;
                frameo_n[7] = frameo_n0;
                end
            4'b1000:  begin
                dout[8] = dout0;
                valido_n[8] = valido_n0;
                frameo_n[8] = frameo_n0;
                end
            4'b1001:  begin
                dout[9] = dout0;
                valido_n[9] = valido_n0;
                frameo_n[9] = frameo_n0;
                end
            4'b1010:  begin
                dout[10] = dout0;
                valido_n[10] = valido_n0;
                frameo_n[10] = frameo_n0;
                end
            4'b1011:  begin
                dout[11] = dout0;
                valido_n[11] = valido_n0;
                frameo_n[11] = frameo_n0;
               end
            4'b1100:  begin
                dout[12] = dout0;
                valido_n[12] = valido_n0;
                frameo_n[12] = frameo_n0;
                end
            4'b1101:  begin
                dout[13] = dout0;
                valido_n[13] = valido_n0;
                frameo_n[13] = frameo_n0;
                end
            4'b1110:  begin
                dout[14] = dout0;
                valido_n[14] = valido_n0;
                frameo_n[14] = frameo_n0;
                end
            4'b1111:  begin
                dout[15] = dout0;
                valido_n[15] = valido_n0;
                frameo_n[15] = frameo_n0;
            end
        endcase
        end
        if(de1) begin
        case(address1)
            4'b0000:  begin
                dout[0] = dout1;
                valido_n[0] = valido_n1;
                frameo_n[0] = frameo_n1;
                end
            4'b0001:  begin
                dout[1] = dout1;
                valido_n[1] = valido_n1;
                frameo_n[1] = frameo_n1;
                end
            4'b0010:  begin
                dout[2] = dout1;
                valido_n[2] = valido_n1;
                frameo_n[2] = frameo_n1;
                end
            4'b0011:  begin
                dout[3] = dout1;
                valido_n[3] = valido_n1;
                frameo_n[3] = frameo_n1;
                end
            4'b0100:  begin
                dout[4] = dout1;
                valido_n[4] = valido_n1;
                frameo_n[4] = frameo_n1;
                end
            4'b0101:  begin
                dout[5] = dout1;
                valido_n[5] = valido_n1;
                frameo_n[5] = frameo_n1;
                end
            4'b0110:  begin
                dout[6] = dout1;
                valido_n[6] = valido_n1;
                frameo_n[6] = frameo_n1;
                end
            4'b0111:  begin
                dout[7] = dout1;
                valido_n[7] = valido_n1;
                frameo_n[7] = frameo_n1;
                end
            4'b1000:  begin
                dout[8] = dout1;
                valido_n[87] = valido_n1;
                frameo_n[87] = frameo_n1;
                end
            4'b1001:  begin
                dout[9] = dout1;
                valido_n[9] = valido_n1;
                frameo_n[9] = frameo_n1;
                end
            4'b1010:  begin
                dout[10] = dout1;
                valido_n[10] = valido_n1;
                frameo_n[10] = frameo_n1;
                end
            4'b1011:  begin
                dout[11] = dout1;
                valido_n[11] = valido_n1;
                frameo_n[11] = frameo_n1;
                end
            4'b1100:  begin
                dout[12] = dout1;
                valido_n[12] = valido_n1;
                frameo_n[12] = frameo_n1;
                end
            4'b1101:  begin
                dout[13] = dout1;
                valido_n[13] = valido_n1;
                frameo_n[13] = frameo_n1;
                end
            4'b1110:  begin
                dout[14] = dout1;
                valido_n[14] = valido_n1;
                frameo_n[14] = frameo_n1;
                end
            4'b1111:  begin
                dout[15] = dout1;
                valido_n[15] = valido_n1;
                frameo_n[15] = frameo_n1;
            end
            endcase
            end
        if(de2) begin
        case(address2)
            4'b0000:  begin
                dout[0] = dout2;
                valido_n[0] = valido_n2;
                frameo_n[0] = frameo_n2;
                end
            4'b0001:  begin
                dout[1] = dout2;
                valido_n[1] = valido_n2;
                frameo_n[1] = frameo_n2;
                end
            4'b0010:  begin
                dout[2] = dout2;
                valido_n[2] = valido_n2;
                frameo_n[2] = frameo_n2;
                end
            4'b0011:  begin
                dout[3] = dout2;
                valido_n[3] = valido_n2;
                frameo_n[3] = frameo_n2;
                end
            4'b0100:  begin
                dout[4] = dout2;
                valido_n[4] = valido_n2;
                frameo_n[4] = frameo_n2;
                end
            4'b0101:  begin
                dout[5] = dout2;
                valido_n[5] = valido_n2;
                frameo_n[5] = frameo_n2;
                end
            4'b0110:  begin
                dout[6] = dout2;
                valido_n[6] = valido_n2;
                frameo_n[6] = frameo_n2;
                end
            4'b0111:  begin
                dout[7] = dout2;
                valido_n[7] = valido_n2;
                frameo_n[7] = frameo_n2;
                end
            4'b1000:  begin
                dout[8] = dout2;
                valido_n[8] = valido_n2;
                frameo_n[8] = frameo_n2;
                end
            4'b1001:  begin
                dout[9] = dout2;
                valido_n[9] = valido_n2;
                frameo_n[9] = frameo_n2;
                end
            4'b1010:  begin
                dout[10] = dout2;
                valido_n[10] = valido_n2;
                frameo_n[10] = frameo_n2;
                end
            4'b1011:  begin
                dout[11] = dout2;
                valido_n[11] = valido_n2;
                frameo_n[11] = frameo_n2;
                end
            4'b1100:  begin
                dout[12] = dout2;
                valido_n[12] = valido_n2;
                frameo_n[12] = frameo_n2;
                end
            4'b1101:  begin
                dout[13] = dout2;
                valido_n[13] = valido_n2;
                frameo_n[13] = frameo_n2;
                end
            4'b1110:  begin
                dout[14] = dout2;
                valido_n[14] = valido_n2;
                frameo_n[14] = frameo_n2;
                end
            4'b1111:  begin
                dout[15] = dout2;
                valido_n[15] = valido_n2;
                frameo_n[15] = frameo_n2;
            end
            endcase
            end
        if(de3) begin
        case(address3)
            4'b0000:  begin
                dout[0] = dout3;
                valido_n[0] = valido_n3;
                frameo_n[0] = frameo_n3;
                end
            4'b0001:  begin
                dout[1] = dout3;
                valido_n[1] = valido_n3;
                frameo_n[1] = frameo_n3;
                end
            4'b0010:  begin
                dout[2] = dout3;
                valido_n[2] = valido_n3;
                frameo_n[2] = frameo_n3;
                end
            4'b0011:  begin
                dout[3] = dout3;
                valido_n[3] = valido_n3;
                frameo_n[3] = frameo_n3;
                end
            4'b0100:  begin
                dout[4] = dout3;
                valido_n[4] = valido_n3;
                frameo_n[4] = frameo_n3;
                end
            4'b0101:  begin
                dout[5] = dout3;
                valido_n[5] = valido_n3;
                frameo_n[5] = frameo_n3;
                end
            4'b0110:  begin
                dout[6] = dout3;
                valido_n[6] = valido_n3;
                frameo_n[6] = frameo_n3;
                end
            4'b0111:  begin
                dout[7] = dout3;
                valido_n[7] = valido_n3;
                frameo_n[7] = frameo_n3;
                end
            4'b1000:  begin
                dout[8] = dout3;
                valido_n[8] = valido_n3;
                frameo_n[8] = frameo_n3;
                end
            4'b1001:  begin
                dout[9] = dout3;
                valido_n[9] = valido_n3;
                frameo_n[9] = frameo_n3;
                end
            4'b1010:  begin
                dout[10] = dout3;
                valido_n[10] = valido_n3;
                frameo_n[10] = frameo_n3;
                end
            4'b1011:  begin
                dout[11] = dout3;
                valido_n[11] = valido_n3;
                frameo_n[11] = frameo_n3;
                end
            4'b1100:  begin
                dout[12] = dout3;
                valido_n[12] = valido_n3;
                frameo_n[12] = frameo_n3;
                end
            4'b1101:  begin
                dout[13] = dout3;
                valido_n[13] = valido_n3;
                frameo_n[13] = frameo_n3;
                end
            4'b1110:  begin
                dout[14] = dout3;
                valido_n[14] = valido_n3;
                frameo_n[14] = frameo_n3;
                end
            4'b1111:  begin
                dout[15] = dout3;
                valido_n[15] = valido_n3;
                frameo_n[15] = frameo_n3;
            end
            endcase
            end
        if(de4) begin
        case(address4)
            4'b0000:  begin
                dout[0] = dout4;
                valido_n[0] = valido_n4;
                frameo_n[0] = frameo_n4;
                end
            4'b0001:  begin
                dout[1] = dout4;
                valido_n[1] = valido_n4;
                frameo_n[1] = frameo_n4;
                end
            4'b0010:  begin
                dout[2] = dout4;
                valido_n[2] = valido_n4;
                frameo_n[2] = frameo_n4;
                end
            4'b0011:  begin
                dout[3] = dout4;
                valido_n[3] = valido_n4;
                frameo_n[3] = frameo_n4;
                end
            4'b0100:  begin
                dout[4] = dout4;
                valido_n[4] = valido_n4;
                frameo_n[4] = frameo_n4;
                end
            4'b0101:  begin
                dout[5] = dout4;
                valido_n[5] = valido_n4;
                frameo_n[5] = frameo_n4;
                end
            4'b0110:  begin
                dout[6] = dout4;
                valido_n[6] = valido_n4;
                frameo_n[6] = frameo_n4;
                end
            4'b0111:  begin
                dout[7] = dout4;
                valido_n[7] = valido_n4;
                frameo_n[7] = frameo_n4;
                end
            4'b1000:  begin
                dout[8] = dout4;
                valido_n[8] = valido_n4;
                frameo_n[8] = frameo_n4;
                end
            4'b1001:  begin
                dout[9] = dout4;
                valido_n[9] = valido_n4;
                frameo_n[9] = frameo_n4;
                end
            4'b1010:  begin
                dout[10] = dout4;
                valido_n[10] = valido_n4;
                frameo_n[10] = frameo_n4;
                end
            4'b1011:  begin
                dout[11] = dout4;
                valido_n[11] = valido_n4;
                frameo_n[11] = frameo_n4;
                end
            4'b1100:  begin
                dout[12] = dout4;
                valido_n[12] = valido_n4;
                frameo_n[12] = frameo_n4;
                end
            4'b1101:  begin
                dout[13] = dout4;
                valido_n[13] = valido_n4;
                frameo_n[13] = frameo_n4;
                end
            4'b1110:  begin
                dout[14] = dout4;
                valido_n[14] = valido_n4;
                frameo_n[14] = frameo_n4;
                end
            4'b1111:  begin
                dout[15] = dout4;
                valido_n[15] = valido_n4;
                frameo_n[15] = frameo_n4;
            end
            endcase
            end
        if(de5) begin
        case(address5)
            4'b0000:  begin
                dout[0] = dout5;
                valido_n[0] = valido_n5;
                frameo_n[0] = frameo_n5;
                end
            4'b0001:  begin
                dout[1] = dout5;
                valido_n[1] = valido_n5;
                frameo_n[1] = frameo_n5;
                end
            4'b0010:  begin
                dout[2] = dout5;
                valido_n[2] = valido_n5;
                frameo_n[2] = frameo_n5;
                end
            4'b0011:  begin
                dout[3] = dout5;
                valido_n[3] = valido_n5;
                frameo_n[3] = frameo_n5;
                end
            4'b0100:  begin
                dout[4] = dout5;
                valido_n[4] = valido_n5;
                frameo_n[4] = frameo_n5;
                end
            4'b0101:  begin
                dout[5] = dout5;
                valido_n[5] = valido_n5;
                frameo_n[5] = frameo_n5;
                end
            4'b0110:  begin
                dout[6] = dout5;
                valido_n[6] = valido_n5;
                frameo_n[6] = frameo_n5;
                end
            4'b0111:  begin
                dout[7] = dout5;
                valido_n[7] = valido_n5;
                frameo_n[7] = frameo_n5;
                end
            4'b1000:  begin
                dout[8] = dout5;
                valido_n[8] = valido_n5;
                frameo_n[8] = frameo_n5;
                end
            4'b1001:  begin
                dout[9] = dout5;
                valido_n[9] = valido_n5;
                frameo_n[9] = frameo_n5;
                end
            4'b1010:  begin
                dout[10] = dout5;
                valido_n[10] = valido_n5;
                frameo_n[10] = frameo_n5;
                end
            4'b1011:  begin
                dout[11] = dout5;
                valido_n[11] = valido_n5;
                frameo_n[11] = frameo_n5;
                end
            4'b1100:  begin
                dout[12] = dout5;
                valido_n[12] = valido_n5;
                frameo_n[12] = frameo_n5;
                end
            4'b1101:  begin
                dout[13] = dout5;
                valido_n[13] = valido_n5;
                frameo_n[13] = frameo_n5;
                end
            4'b1110:  begin
                dout[14] = dout5;
                valido_n[14] = valido_n5;
                frameo_n[14] = frameo_n5;
                end
            4'b1111:  begin
                dout[15] = dout5;
                valido_n[15] = valido_n5;
                frameo_n[15] = frameo_n5;
            end
            endcase
        end
        if(de6) begin
        case(address6)
            4'b0000:  begin
                dout[0] = dout6;
                valido_n[0] = valido_n6;
                frameo_n[0] = frameo_n6;
                end
            4'b0001:  begin
                dout[1] = dout6;
                valido_n[1] = valido_n6;
                frameo_n[1] = frameo_n6;
                end
            4'b0010:  begin
                dout[2] = dout6;
                valido_n[2] = valido_n6;
                frameo_n[2] = frameo_n6;
                end
            4'b0011:  begin
                dout[3] = dout6;
                valido_n[3] = valido_n6;
                frameo_n[3] = frameo_n6;
                end
            4'b0100:  begin
                dout[4] = dout6;
                valido_n[4] = valido_n6;
                frameo_n[4] = frameo_n6;
                end
            4'b0101:  begin
                dout[5] = dout6;
                valido_n[5] = valido_n6;
                frameo_n[5] = frameo_n6;
                end
            4'b0110:  begin
                dout[6] = dout6;
                valido_n[6] = valido_n6;
                frameo_n[6] = frameo_n6;
                end
            4'b0111:  begin
                dout[7] = dout6;
                valido_n[7] = valido_n6;
                frameo_n[7] = frameo_n6;
                end
            4'b1000:  begin
                dout[8] = dout6;
                valido_n[8] = valido_n6;
                frameo_n[8] = frameo_n6;
                end
            4'b1001:  begin
                dout[9] = dout6;
                valido_n[9] = valido_n6;
                frameo_n[9] = frameo_n6;
                end
            4'b1010:  begin
                dout[10] = dout6;
                valido_n[10] = valido_n6;
                frameo_n[10] = frameo_n6;
                end
            4'b1011:  begin
                dout[11] = dout6;
                valido_n[11] = valido_n6;
                frameo_n[11] = frameo_n6;
                end
            4'b1100:  begin
                dout[12] = dout6;
                valido_n[12] = valido_n6;
                frameo_n[12] = frameo_n6;
                end
            4'b1101:  begin
                dout[13] = dout6;
                valido_n[13] = valido_n6;
                frameo_n[13] = frameo_n6;
                end
            4'b1110:  begin
                dout[14] = dout6;
                valido_n[14] = valido_n6;
                frameo_n[14] = frameo_n6;
                end
            4'b1111:  begin
                dout[15] = dout6;
                valido_n[15] = valido_n6;
                frameo_n[15] = frameo_n6;
            end
            endcase
            end
        if(de7) begin
        case(address7)
            4'b0000:  begin
                dout[0] = dout7;
                valido_n[0] = valido_n7;
                frameo_n[0] = frameo_n7;
                end
            4'b0001:  begin
                dout[1] = dout7;
                valido_n[1] = valido_n7;
                frameo_n[1] = frameo_n7;
                end
            4'b0010:  begin
                dout[2] = dout7;
                valido_n[2] = valido_n7;
                frameo_n[2] = frameo_n7;
                end
            4'b0011:  begin
                dout[3] = dout7;
                valido_n[3] = valido_n7;
                frameo_n[3] = frameo_n7;
                end
            4'b0100:  begin
                dout[4] = dout7;
                valido_n[4] = valido_n7;
                frameo_n[4] = frameo_n7;
                end
            4'b0101:  begin
                dout[5] = dout7;
                valido_n[5] = valido_n7;
                frameo_n[5] = frameo_n7;
                end
            4'b0110:  begin
                dout[6] = dout7;
                valido_n[6] = valido_n7;
                frameo_n[6] = frameo_n7;
                end
            4'b0111:  begin
                dout[7] = dout7;
                valido_n[7] = valido_n7;
                frameo_n[7] = frameo_n7;
                end
            4'b1000:  begin
                dout[8] = dout7;
                valido_n[8] = valido_n7;
                frameo_n[8] = frameo_n7;
                end
            4'b1001:  begin
                dout[9] = dout7;
                valido_n[9] = valido_n7;
                frameo_n[9] = frameo_n7;
                end
            4'b1010:  begin
                dout[10] = dout7;
                valido_n[10] = valido_n7;
                frameo_n[10] = frameo_n7;
                end
            4'b1011:  begin
                dout[11] = dout7;
                valido_n[11] = valido_n7;
                frameo_n[11] = frameo_n7;
                end
            4'b1100:  begin
                dout[12] = dout7;
                valido_n[12] = valido_n7;
                frameo_n[12] = frameo_n7;
                end
            4'b1101:  begin
                dout[13] = dout7;
                valido_n[13] = valido_n7;
                frameo_n[13] = frameo_n7;
                end
            4'b1110:  begin
                dout[14] = dout7;
                valido_n[14] = valido_n7;
                frameo_n[14] = frameo_n7;
                end
            4'b1111:  begin
                dout[15] = dout7;
                valido_n[15] = valido_n7;
                frameo_n[15] = frameo_n7;
            end
            endcase
            end
        if(de8) begin
        case(address8)
            4'b0000:  begin
                dout[0] = dout8;
                valido_n[0] = valido_n8;
                frameo_n[0] = frameo_n8;
                end
            4'b0001:  begin
                dout[1] = dout8;
                valido_n[1] = valido_n8;
                frameo_n[1] = frameo_n8;
                end
            4'b0010:  begin
                dout[2] = dout8;
                valido_n[2] = valido_n8;
                frameo_n[2] = frameo_n8;
                end
            4'b0011:  begin
                dout[3] = dout8;
                valido_n[3] = valido_n8;
                frameo_n[3] = frameo_n8;
                end
            4'b0100:  begin
                dout[4] = dout8;
                valido_n[4] = valido_n8;
                frameo_n[4] = frameo_n8;
                end
            4'b0101:  begin
                dout[5] = dout8;
                valido_n[5] = valido_n8;
                frameo_n[5] = frameo_n8;
                end
            4'b0110:  begin
                dout[6] = dout8;
                valido_n[6] = valido_n8;
                frameo_n[6] = frameo_n8;
                end
            4'b0111:  begin
                dout[7] = dout8;
                valido_n[7] = valido_n8;
                frameo_n[7] = frameo_n8;
                end
            4'b1000:  begin
                dout[8] = dout8;
                valido_n[8] = valido_n8;
                frameo_n[8] = frameo_n8;
                end
            4'b1001:  begin
                dout[9] = dout8;
                valido_n[9] = valido_n8;
                frameo_n[9] = frameo_n8;
                end
            4'b1010:  begin
                dout[10] = dout8;
                valido_n[10] = valido_n8;
                frameo_n[10] = frameo_n8;
                end
            4'b1011:  begin
                dout[11] = dout8;
                valido_n[11] = valido_n8;
                frameo_n[11] = frameo_n8;
                end
            4'b1100:  begin
                dout[12] = dout8;
                valido_n[12] = valido_n8;
                frameo_n[12] = frameo_n8;
                end
            4'b1101:  begin
                dout[13] = dout8;
                valido_n[13] = valido_n8;
                frameo_n[13] = frameo_n8;
                end
            4'b1110:  begin
                dout[14] = dout8;
                valido_n[14] = valido_n8;
                frameo_n[14] = frameo_n8;
                end
            4'b1111:  begin
                dout[15] = dout8;
                valido_n[15] = valido_n8;
                frameo_n[15] = frameo_n8;
            end
        endcase
        end
        if(de9) begin
        case(address9)
            4'b0000:  begin
                dout[0] = dout9;
                valido_n[0] = valido_n9;
                frameo_n[0] = frameo_n9;
                end
            4'b0001:  begin
                dout[1] = dout9;
                valido_n[1] = valido_n9;
                frameo_n[1] = frameo_n9;
                end
            4'b0010:  begin
                dout[2] = dout9;
                valido_n[2] = valido_n9;
                frameo_n[2] = frameo_n9;
                end
            4'b0011:  begin
                dout[3] = dout9;
                valido_n[3] = valido_n9;
                frameo_n[3] = frameo_n9;
                end
            4'b0100:  begin
                dout[4] = dout9;
                valido_n[4] = valido_n9;
                frameo_n[4] = frameo_n9;
                end
            4'b0101:  begin
                dout[5] = dout9;
                valido_n[5] = valido_n9;
                frameo_n[5] = frameo_n9;
                end
            4'b0110:  begin
                dout[6] = dout9;
                valido_n[6] = valido_n9;
                frameo_n[6] = frameo_n9;
                end
            4'b0111:  begin
                dout[7] = dout9;
                valido_n[7] = valido_n9;
                frameo_n[7] = frameo_n9;
                end
            4'b1000:  begin
                dout[8] = dout9;
                valido_n[8] = valido_n9;
                frameo_n[8] = frameo_n9;
                end
            4'b1001:  begin
                dout[9] = dout9;
                valido_n[9] = valido_n9;
                frameo_n[9] = frameo_n9;
                end
            4'b1010:  begin
                dout[10] = dout9;
                valido_n[10] = valido_n9;
                frameo_n[10] = frameo_n9;
                end
            4'b1011:  begin
                dout[11] = dout9;
                valido_n[11] = valido_n9;
                frameo_n[11] = frameo_n9;
                end
            4'b1100:  begin
                dout[12] = dout9;
                valido_n[12] = valido_n9;
                frameo_n[12] = frameo_n9;
                end
            4'b1101:  begin
                dout[13] = dout9;
                valido_n[13] = valido_n9;
                frameo_n[13] = frameo_n9;
                end
            4'b1110:  begin
                dout[14] = dout9;
                valido_n[14] = valido_n9;
                frameo_n[14] = frameo_n9;
                end
            4'b1111:  begin
                dout[15] = dout9;
                valido_n[15] = valido_n9;
                frameo_n[15] = frameo_n9;
            end
        endcase
        end
        if(de10) begin
        case(address10)
            4'b0000:  begin
                dout[0] = dout10;
                valido_n[0] = valido_n10;
                frameo_n[0] = frameo_n10;
                end
            4'b0001:  begin
                dout[1] = dout10;
                valido_n[1] = valido_n10;
                frameo_n[1] = frameo_n10;
                end
            4'b0010:  begin
                dout[2] = dout10;
                valido_n[2] = valido_n10;
                frameo_n[2] = frameo_n10;
                end
            4'b0011:  begin
                dout[3] = dout10;
                valido_n[3] = valido_n10;
                frameo_n[3] = frameo_n10;
                end
            4'b0100:  begin
                dout[4] = dout10;
                valido_n[4] = valido_n10;
                frameo_n[4] = frameo_n10;
                end
            4'b0101:  begin
                dout[5] = dout10;
                valido_n[5] = valido_n10;
                frameo_n[5] = frameo_n10;
                end
            4'b0110:  begin
                dout[6] = dout10;
                valido_n[6] = valido_n10;
                frameo_n[6] = frameo_n10;
                end
            4'b0111:  begin
                dout[7] = dout10;
                valido_n[7] = valido_n10;
                frameo_n[7] = frameo_n10;
                end
            4'b1000:  begin
                dout[8] = dout10;
                valido_n[8] = valido_n10;
                frameo_n[8] = frameo_n10;
                end
            4'b1001:  begin
                dout[9] = dout10;
                valido_n[9] = valido_n10;
                frameo_n[9] = frameo_n10;
                end
            4'b1010:  begin
                dout[10] = dout10;
                valido_n[10] = valido_n10;
                frameo_n[10] = frameo_n10;
                end
            4'b1011:  begin
                dout[11] = dout10;
                valido_n[11] = valido_n10;
                frameo_n[11] = frameo_n10;
                end
            4'b1100:  begin
                dout[12] = dout10;
                valido_n[12] = valido_n10;
                frameo_n[12] = frameo_n10;
                end
            4'b1101:  begin
                dout[13] = dout10;
                valido_n[13] = valido_n10;
                frameo_n[13] = frameo_n10;
                end
            4'b1110:  begin
                dout[14] = dout10;
                valido_n[14] = valido_n10;
                frameo_n[14] = frameo_n10;
                end
            4'b1111:  begin
                dout[15] = dout10;
                valido_n[15] = valido_n10;
                frameo_n[15] = frameo_n10;
                end
            endcase
            end
        if(de11) begin
        case(address11)
            4'b0000:  begin
                dout[0] = dout11;
                valido_n[0] = valido_n11;
                frameo_n[0] = frameo_n11;
                end
            4'b0001:  begin
                dout[1] = dout11;
                valido_n[1] = valido_n11;
                frameo_n[1] = frameo_n11;
                end
            4'b0010:  begin
                dout[2] = dout11;
                valido_n[2] = valido_n11;
                frameo_n[2] = frameo_n11;
                end
            4'b0011:  begin
                dout[3] = dout11;
                valido_n[3] = valido_n11;
                frameo_n[3] = frameo_n11;
                end
            4'b0100:  begin
                dout[4] = dout11;
                valido_n[4] = valido_n11;
                frameo_n[4] = frameo_n11;
    
                end
            4'b0101:  begin
                dout[5] = dout11;
                valido_n[5] = valido_n11;
                frameo_n[5] = frameo_n11;
                end
            4'b0110:  begin
                dout[6] = dout11;
                valido_n[6] = valido_n11;
                frameo_n[6] = frameo_n11;
                end
            4'b0111:  begin
                dout[7] = dout11;
                valido_n[7] = valido_n11;
                frameo_n[7] = frameo_n11;
                end
            4'b1000:  begin
                dout[8] = dout11;
                valido_n[8] = valido_n11;
                frameo_n[8] = frameo_n11;
                end
            4'b1001:  begin
                dout[9] = dout11;
                valido_n[9] = valido_n11;
                frameo_n[9] = frameo_n11;
                end
            4'b1010:  begin
                dout[10] = dout11;
                valido_n[10] = valido_n11;
                frameo_n[10] = frameo_n11;
                end
            4'b1011:  begin
                dout[11] = dout11;
                valido_n[11] = valido_n11;
                frameo_n[11] = frameo_n11;
                end
            4'b1100:  begin
                dout[12] = dout11;
                valido_n[12] = valido_n11;
                frameo_n[12] = frameo_n11;
                end
            4'b1101:  begin
                dout[13] = dout11;
                valido_n[13] = valido_n11;
                frameo_n[13] = frameo_n11;
                end
            4'b1110:  begin
                dout[14] = dout11;
                valido_n[14] = valido_n11;
                frameo_n[14] = frameo_n11;
                end
            4'b1111:  begin
                dout[15] = dout11;
                valido_n[15] = valido_n11;
                frameo_n[15] = frameo_n11;
                end
            endcase
            end
        if(de12) begin
        case(address12)
            4'b0000:  begin
                dout[0] = dout12;
                valido_n[0] = valido_n12;
                frameo_n[0] = frameo_n12;
                end
            4'b0001:  begin
                dout[1] = dout12;
                valido_n[1] = valido_n12;
                frameo_n[1] = frameo_n12;
                end
            4'b0010:  begin
                dout[2] = dout12;
                valido_n[2] = valido_n12;
                frameo_n[2] = frameo_n12;
                end
            4'b0011:  begin
                dout[3] = dout12;
                valido_n[3] = valido_n12;
                frameo_n[3] = frameo_n12;
                end
            4'b0100:  begin
                dout[4] = dout12;
                valido_n[4] = valido_n12;
                frameo_n[4] = frameo_n12;
                end
            4'b0101:  begin
                dout[5] = dout12;
                valido_n[5] = valido_n12;
                frameo_n[5] = frameo_n12;
                end
            4'b0110:  begin
                dout[6] = dout12;
                valido_n[6] = valido_n12;
                frameo_n[6] = frameo_n12;
                end
            4'b0111:  begin
                dout[7] = dout12;
                valido_n[7] = valido_n12;
                frameo_n[7] = frameo_n12;
                end
            4'b1000:  begin
                dout[8] = dout12;
                valido_n[8] = valido_n12;
                frameo_n[8] = frameo_n12;
                end
            4'b1001:  begin
                dout[9] = dout12;
                valido_n[9] = valido_n12;
                frameo_n[9] = frameo_n12;
                end
            4'b1010:  begin
                dout[10] = dout12;
                valido_n[10] = valido_n12;
                frameo_n[10] = frameo_n12;
                end
            4'b1011:  begin
                dout[11] = dout12;
                valido_n[11] = valido_n12;
                frameo_n[11] = frameo_n12;
                end
            4'b1100:  begin
                dout[12] = dout12;
                valido_n[12] = valido_n12;
                frameo_n[12] = frameo_n12;
                end
            4'b1101:  begin
                dout[13] = dout12;
                valido_n[13] = valido_n12;
                frameo_n[13] = frameo_n12;
                end
            4'b1110:  begin
                dout[14] = dout12;
                valido_n[14] = valido_n12;
                frameo_n[14] = frameo_n12;
                end
            4'b1111:  begin
                dout[15] = dout12;
                valido_n[15] = valido_n12;
                frameo_n[15] = frameo_n12;
                end
            endcase
            end
        if(de13) begin
        case(address13)
            4'b0000:  begin
                dout[0] = dout13;
                valido_n[0] = valido_n13;
                frameo_n[0] = frameo_n13;
                end
            4'b0001:  begin
                dout[1] = dout13;
                valido_n[1] = valido_n13;
                frameo_n[1] = frameo_n13;
                end
            4'b0010:  begin
                dout[2] = dout13;
                valido_n[2] = valido_n13;
                frameo_n[2] = frameo_n13;
                end
            4'b0011:  begin
                dout[3] = dout13;
                valido_n[3] = valido_n13;
                frameo_n[3] = frameo_n13;
                end
            4'b0100:  begin
                dout[4] = dout13;
                valido_n[4] = valido_n13;
                frameo_n[4] = frameo_n13;
                end
            4'b0101:  begin
                dout[5] = dout13;
                valido_n[5] = valido_n13;
                frameo_n[5] = frameo_n13;
                end
            4'b0110:  begin
                dout[6] = dout13;
                valido_n[6] = valido_n13;
                frameo_n[6] = frameo_n13;
                end
            4'b0111:  begin
                dout[7] = dout13;
                valido_n[7] = valido_n13;
                frameo_n[7] = frameo_n13;
                end
            4'b1000:  begin
                dout[8] = dout13;
                valido_n[8] = valido_n13;
                frameo_n[8] = frameo_n13;
                end
            4'b1001:  begin
                dout[9] = dout13;
                valido_n[9] = valido_n13;
                frameo_n[9] = frameo_n13;
                end
            4'b1010:  begin
                dout[10] = dout13;
                valido_n[10] = valido_n13;
                frameo_n[10] = frameo_n13;
                end
            4'b1011:  begin
                dout[11] = dout13;
                valido_n[11] = valido_n13;
                frameo_n[11] = frameo_n13;
                end
            4'b1100:  begin
                dout[12] = dout13;
                valido_n[12] = valido_n13;
                frameo_n[12] = frameo_n13;
                end
            4'b1101:  begin
                dout[13] = dout13;
                valido_n[13] = valido_n13;
                frameo_n[13] = frameo_n13;
                end
            4'b1110:  begin
                dout[14] = dout13;
                valido_n[14] = valido_n13;
                frameo_n[14] = frameo_n13;
                end
            4'b1111:  begin
                dout[15] = dout13;
                valido_n[15] = valido_n13;
                frameo_n[15] = frameo_n13;
                end
            endcase
            end
        if(de14) begin
        case(address14)
            4'b0000:  begin
                dout[0] = dout14;
                valido_n[0] = valido_n14;
                frameo_n[0] = frameo_n14;
                end
            4'b0001:  begin
                dout[1] = dout14;
                valido_n[1] = valido_n14;
                frameo_n[1] = frameo_n14;
                end
            4'b0010:  begin
                dout[2] = dout14;
                valido_n[2] = valido_n14;
                frameo_n[2] = frameo_n14;
                end
            4'b0011:  begin
                dout[3] = dout14;
                valido_n[3] = valido_n14;
                frameo_n[3] = frameo_n14;
                end
            4'b0100:  begin
                dout[4] = dout14;
                valido_n[4] = valido_n14;
                frameo_n[4] = frameo_n14;
                end
            4'b0101:  begin
                dout[5] = dout14;
                valido_n[5] = valido_n14;
                frameo_n[5] = frameo_n14;
                end
            4'b0110:  begin
                dout[6] = dout14;
                valido_n[6] = valido_n14;
                frameo_n[6] = frameo_n14;
                end
            4'b0111:  begin
                dout[7] = dout14;
                valido_n[7] = valido_n14;
                frameo_n[7] = frameo_n14;
                end
            4'b1000:  begin
                dout[8] = dout14;
                valido_n[8] = valido_n14;
                frameo_n[8] = frameo_n14;
                end
            4'b1001:  begin
                dout[9] = dout14;
                valido_n[10] = valido_n14;
                frameo_n[10] = frameo_n14;
                end
            4'b1010:  begin
                dout[10] = dout14;
                valido_n[10] = valido_n14;
                frameo_n[10] = frameo_n14;
                end
            4'b1011:  begin
                dout[11] = dout14;
                valido_n[11] = valido_n14;
                frameo_n[11] = frameo_n14;
                end
            4'b1100:  begin
                dout[12] = dout14;
                valido_n[12] = valido_n14;
                frameo_n[12] = frameo_n14;
                end
            4'b1101:  begin
                dout[13] = dout14;
                valido_n[13] = valido_n14;
                frameo_n[13] = frameo_n14;
                end
            4'b1110:  begin
                dout[14] = dout14;
                valido_n[14] = valido_n14;
                frameo_n[14] = frameo_n14;
                end
            4'b1111:  begin
                dout[15] = dout14;
                valido_n[15] = valido_n14;
                frameo_n[15] = frameo_n14;
            end
            endcase
            end
        if(de15) begin
        case(address15)
            4'b0000:  begin
                dout[0] = dout15;
                valido_n[0] = valido_n15;
                frameo_n[0] = frameo_n15;
                end
            4'b0001:  begin
                dout[1] = dout15;
                valido_n[1] = valido_n15;
                frameo_n[1] = frameo_n15;
                end
            4'b0010:  begin
                dout[2] = dout15;
                valido_n[2] = valido_n15;
                frameo_n[2] = frameo_n15;
                end
            4'b0011:  begin
                dout[3] = dout15;
                valido_n[3] = valido_n15;
                frameo_n[3] = frameo_n15;
                end
            4'b0100:  begin
                dout[4] = dout15;
                valido_n[4] = valido_n15;
                frameo_n[4] = frameo_n15;
                end
            4'b0101:  begin
                dout[5] = dout15;
                valido_n[5] = valido_n15;
                frameo_n[5] = frameo_n15;
                end
            4'b0110:  begin
                dout[6] = dout15;
                valido_n[6] = valido_n15;
                frameo_n[6] = frameo_n15;
                end
            4'b0111:  begin
                dout[7] = dout15;
                valido_n[7] = valido_n15;
                frameo_n[7] = frameo_n15;
                end
            4'b1000:  begin
                dout[8] = dout15;
                valido_n[8] = valido_n15;
                frameo_n[8] = frameo_n15;
                end
            4'b1001:  begin
                dout[9] = dout15;
                valido_n[9] = valido_n15;
                frameo_n[9] = frameo_n15;   
                end
            4'b1010:  begin
                dout[10] = dout15;
                valido_n[10] = valido_n15;
                frameo_n[10] = frameo_n15;        
                end
            4'b1011:  begin
                dout[11] = dout15;
                valido_n[11] = valido_n15;
                frameo_n[11] = frameo_n15;
                end
            4'b1100:  begin
                dout[12] = dout15;
                valido_n[12] = valido_n15;
                frameo_n[12] = frameo_n15;
                end
            4'b1101:  begin
                dout[13] = dout15;
                valido_n[13] = valido_n15;
                frameo_n[13] = frameo_n15;
                end
            4'b1110:  begin
                dout[14] = dout15;
                valido_n[14] = valido_n15;
                frameo_n[14] = frameo_n15;
                end
            4'b1111:  begin
                dout[15] = dout15;
                valido_n[15] = valido_n15;
                frameo_n[15] = frameo_n15;
                end
        endcase
        end
    end
endmodule

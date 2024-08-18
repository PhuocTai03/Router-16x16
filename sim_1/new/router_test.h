`ifndef DEF_MAILBOX
`define DEF_MAILBOX
typedef class Packet;
typedef mailbox #(Packet) pkt_mbox; 

interface router_io(input bit clk);
    logic           reset_n;
    logic [15:0]    din;
    logic [15:0]    frame_n;
    logic [15:0]    valid_n;
    logic [15:0]    dout;
    logic [15:0]    frameo_n;
    logic [15:0]    valido_n;
    clocking driver_cb @(negedge clk);
        output  din;
        output  frame_n;
        output  valid_n;
    endclocking
    clocking receiver_cb @(negedge clk);    
        input   dout;
        input   valido_n;
        input   frameo_n;
    endclocking
    modport DRIVER  (clocking driver_cb, output reset_n);
    modport RECEIVER (clocking receiver_cb, output reset_n);
endinterface: router_io
`endif
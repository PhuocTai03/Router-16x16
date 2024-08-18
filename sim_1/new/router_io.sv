//interface router_io_oldversion(input bit clk);
//    logic           reset_n;
//    logic [15:0]    din;
//    logic [15:0]    frame_n;
//    logic [15:0]    valid_n;
//    logic [15:0]    dout;
//    logic [15:0]    frameo_n;
//    logic [15:0]    valido_n;
//    clocking cb @(negedge clk);
//        output  reset_n;
//        output  din;
//        output  frame_n;
//        output  valid_n;
//        input   dout;
//        input   valido_n;
//        input   frameo_n;
//    endclocking
//    modport tb (clocking cb, output reset_n);
//endinterface: router_io_oldversion

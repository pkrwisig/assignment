module tb ();

//parameter
localparam packet_length = 8;
localparam DW = 8;

//ports
reg clk;
reg rst;

reg [DW:0]config_k;


reg [7:0]in_data;
reg in_valid;
wire in_ready;
reg in_last;

wire [7:0]out_data;
wire out_valid;
reg out_ready;
wire out_last;

axi_pkt #(packet_length,DW)
dut (clk,rst,config_k,in_data,in_valid,in_ready,in_last,out_data,out_valid,out_ready,out_last);
// clock generation
always #5 clk = ~clk;

initial begin
clk = 0;
rst =1;
config_k = 8'd03;
in_data = 0;
in_valid = 0;
in_last = 0;
out_ready = 0;

repeat(8)@(posedge clk);
rst = 0;
repeat(8) begin
        repeat(7) begin
         in_last = 0;
         in_valid  = 1;
         out_ready =1;
         in_data = in_data + 1;
         @(posedge clk);
         end
 in_valid  = 1;
 out_ready =1;
 in_data = in_data + 1;
 in_last =1;
 @(posedge clk);
 end
repeat(20) @(posedge clk);

$finish;
end
endmodule

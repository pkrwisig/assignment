module axi_pkt # (
parameter packet_length = 8,
parameter DW = 8
)
(
input clk,
input rst,

input [DW-1:0]config_k,


input [7:0]in_data,
input in_valid,
output in_ready,
input in_last,

output [7:0]out_data,
output out_valid,
input out_ready,
output out_last
    );
    
     
   
   function integer log2 (input integer depth);
		begin
			for(log2=0; depth>0; log2=log2+1)
				depth = depth >> 1;
		end
	endfunction


    localparam AW = log2(packet_length) - 1;    

   

    
    reg [DW -1:0]mem1[packet_length-1:0];  
    reg [DW -1:0]mem2[packet_length-1:0];  
    reg [DW -1:0]mem3[packet_length-1:0];  
    
    reg [AW-1:0] ptr1 = 0;
    reg [AW-1:0] ptr2 = 0; 
    reg [AW-1:0] ptr3 = 0;
    
    reg [7:0]r_out;   
    reg r_valid;
    reg r_last;  
            
    wire [AW-1 : 0]stop;
    reg r_input_tlast;
    reg count = 1;
    
    assign  stop = packet_length - config_k;    
    assign out_data = r_out;
    assign out_valid = r_valid;
    assign out_last = r_last; 
    assign in_ready = (rst) ? 1: 0;


     integer i;
    
    initial begin
    
    for (i = 0; i < (packet_length); i = i + 1) begin
        mem1[i] = 8'h00; 
        mem2[i] = 8'h00;
        mem3[i] = 8'h00;
    end
    end
    
    always@(posedge clk)              // input tp mem 1
    begin 
    if(rst) begin
    mem1[ptr1] <= 0;
    ptr1 <= 0;
    end
    else begin
     if (in_valid) begin
       mem1[ptr1] <= in_data;
       ptr1<=ptr1+1;
       end
        else begin 
        mem1[ptr1] <= mem1[ptr1];
        ptr1<=ptr1; 
        end
        end
    end
    
    
    
    
    
     always@(posedge clk)           
    begin 
    if(rst) begin 
    r_input_tlast <= 0;
    ptr3<= 0;
    end
    else begin
    r_input_tlast <= in_last;
   ptr3 <= ptr1;
    end
    end   
   
    always@(posedge clk)    
    begin
           if(ptr2 >= stop)
           begin
           mem2[ptr2] <= mem1[ptr1];        
 
           ptr2 <= ptr2 + 1;             
           
           end
             else begin
             mem2[ptr2] <= mem2[ptr2];
             ptr2 <= 0;
             end
    end
    

always@(posedge clk)                              
begin
            if (count) begin
            mem3[ptr3] <= mem1 [ptr1];
            count <= 0; 
            end
            else begin
             mem3[ptr3] <= mem1[ptr1] + mem2[ptr2];
            end
      end
 
 
    always@(posedge clk)    
    begin
     if (rst) 
    begin
    r_out<= 0;
    r_out <= 0;
    r_out<= 0;
    end
    else begin
         if(in_valid && out_ready) begin
         r_out <= mem3[ptr3];
         r_valid <= 1;
         r_last <= r_input_tlast;
         end
         else begin
         r_out <= r_out;
         r_valid <= 0;
         r_last <= r_last;
         end
    end

    end
endmodule

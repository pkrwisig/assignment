module register (
    input            clk,reset,
    input [7:0]      input_tdata,
    input            input_tvalid,
    input            input_tlast,
    output          input_tready,

    output  reg         output_tvalid,
    output reg [7:0] output_tdata,
    output reg          output_tlast,
    input             output_tready          
);

reg [7:0]   temp_data;
reg         temp_last;
reg         temp_valid;


reg r_temp;

always@(posedge clk)begin
r_temp <=  output_tready;
end 

assign input_tready = r_temp;
   //assign   input_tlast= input_tdata[7];

//input side

always@(posedge clk)begin
    if(reset)begin
        temp_data<=0;
        temp_last<=0;
        temp_valid<=0;
        
        end
    else 
        if(input_tready && input_tvalid)begin
        temp_data<=input_tdata;
        temp_last<=input_tlast;
        temp_valid<=1;
        end
        else begin
            temp_data<=0;
            temp_last<=0;
            temp_valid <=0;
        end
end




//output side 

 always@(posedge clk)begin
    if(reset)begin
        output_tvalid<=0;
        output_tlast<=0;
        output_tdata<=0;
        
        end
    else if(output_tready && temp_valid)
        begin
            output_tvalid<=1;
            output_tdata<=temp_data;
            output_tlast<=temp_last;
        end
      else
        begin
            output_tvalid<=0;
            output_tdata<=0;
            output_tlast<=0;
        end
end



endmodule

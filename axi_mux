module  axi_mux(
    input              clk,reset,

    input[7:0]          i_tdata0,
    input               i_tvalid0,
    input               i_tlast0,
    output              i_tready0,

    input[7:0]          i_tdata1,
    input               i_tvalid1,
    input               i_tlast1,
    output              i_tready1,


    input               i_tsel,
    input               i_tsel_valid,
    output              i_tsel_ready,

    output reg [7:0]      o_tdata,
    output reg            o_tvalid,
    output reg            o_tlast,
    input                 o_tready

);


reg[7:0] temp_data;
reg temp_valid;
reg      temp_last;
wire       temp_ready;


reg      temp_sel;
reg      temp_svalid;

assign i_tready0=o_tready;
assign i_tready1=o_tready;
assign i_tsel_ready=o_tready;
assign temp_ready= o_tready;

//select
always@(posedge clk)
begin
    if(reset)begin
        temp_sel<=0;
        temp_svalid<=0;  end
    
    else if(i_tsel_valid && temp_ready)begin
        temp_sel<=i_tsel;
        temp_svalid<=1;
    end

    else temp_svalid<=0;
end

//ip

always@(posedge clk)begin
    if(reset)begin
        temp_data<=0;
        temp_last<=0;
        temp_valid<=0;
    
    end
    else if ((i_tvalid0 | i_tvalid1)  && temp_ready)begin
        temp_data<= temp_sel? i_tdata1 : i_tdata0;

        temp_last<= temp_sel? i_tlast1 : i_tlast0 ;
        temp_valid<=1;
    
    end

    else temp_valid<=0;
    
end

//op

always@(posedge clk)begin
    if(reset)begin
        o_tdata<=0;
        o_tvalid<=0;
        o_tlast<=0;
     
    end
    else if(temp_valid &&  o_tready && i_tsel_valid)begin
    
        o_tdata<=temp_data;
        o_tlast<= temp_last;
        o_tvalid<=1;
    end

     else o_tvalid<=0;

end

endmodule

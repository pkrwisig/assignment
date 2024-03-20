module fp_mul#(
parameter i1 = 2,
parameter f1 = 14,
parameter i2 = 2,
parameter f2 = 14,
parameter i3 = 2,
parameter f3 = 14
)(
input [i1+f1-1 :0] in1,
input i_sign1,
input [i2+f2-1 :0] in2,
input i_sign2,
output [i3+f3-1 :0] out,
output o_sign,
output reg overflow,
output reg underflow
);
localparam max_i=i1+i2;
localparam max_f=f1+f2;
localparam temp_width= max_i+max_f;
//localparam shift=max_f-f3;


localparam total_ofbits= max_i-i3+1;
localparam total_ufbits= max_f-f3;

reg [i3+f3-1 :0] out_ref;
reg [temp_width-1 :0] temp;
reg [temp_width-1 :0] p1;
reg [temp_width-1 :0] p2;    //4.28

reg overflow_may = max_i>i3;
reg underflow_may = max_f>f3;

assign o_sign = i_sign1 || i_sign2;

always_comb begin
    if (o_sign) begin
        if (i_sign1) p1 = $signed(in1);
        else p1 = in1;
        if (i_sign2) p2 = $signed(in2);
        else p2 = in2;
        temp=$signed(p1) * $signed(p2);
        
        overflow = overflow_may? (temp[temp_width - 1]? (~&temp[temp_width - 1 -: total_ofbits] == temp[temp_width - 1]):|temp[temp_width - 1:temp_width -max_i+i3-1]):0;
        underflow = underflow_may?|$signed(temp[temp_width-max_i-1+i3:max_f-f3])?0:|$signed(temp[max_f-f3-1:0]):0;

         out_ref=overflow?temp[temp_width - 1]?{{i3+f3}{1'b0}}:{{i3+f3}{1'b1}}:$signed(temp[temp_width-max_i-1+i3:max_f-f3]);
         end
    else begin
    
        temp=in1*in2;
         overflow=overflow_may?temp[temp_width-1]:0;
            underflow = underflow_may?|temp[temp_width-max_i-1+i3:max_f-f3]?0:|temp[max_f-f3-1:0]:0;
        out_ref=overflow?{{i3+f3}{1'b1}}:temp[temp_width-max_i+i3-1:max_f-f3];
       end



end

assign out = out_ref;

endmodule

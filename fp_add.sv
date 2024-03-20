module fp_add#(
parameter i1 = 2,
parameter f1 = 14,
parameter i2 = 2,
parameter f2 = 14,
parameter i3 = 2,
parameter f3 = 14
)

(
input [i1+f1-1 :0] in1,
input i_sign1,
input [i2+f2-1 :0] in2,
input i_sign2,
output [i3+f3-1 :0] out,
output o_sign,
output reg overflow,
output underflow
);


localparam max_i =i1>i2 ? i1+1:i2+1;
localparam max_f =f1>f2?f1:f2;
localparam temp_width = max_i+max_f;

//localparam shift=max_f-f3;
localparam total_ofbits = max_i-i3+1;


reg [i3+f3-1 :0] out_ref;

reg [temp_width-1 :0] temp_out;
reg [temp_width-1 :0] p1;
reg [temp_width-1 :0] p2;   

//reg overflow_may = max_i>i3;
//reg underflow_may = max_f>f3;
assign underflow = max_f>f3;


assign o_sign = i_sign1 || i_sign2;



always_comb begin
    if (o_sign) begin
        if (i_sign1)
         p1 = $signed(in1);
        else 
            p1 = in1;

        if (i_sign2) 
         p2 = $signed(in2);
        else 
            p2 = in2;

        temp_out=$signed(p1) + $signed(p2);
        
        overflow =temp_out[temp_width - 1]? (~&temp_out[temp_width - 1 -: total_ofbits] == temp_out[temp_width - 1]):|temp_out[temp_width - 1:temp_width -max_i+i3-1];
            
        
        out_ref={overflow?{{{i3+f3}{1'b1}}}:$signed(temp_out[i3+f3-1:0])};
    end
    else begin
        temp_out=in1+in2;
       
         if(i3+f3>=temp_width)
            overflow=0;
            else
            overflow=temp_out[temp_width-1];
        out_ref=overflow?{{{i3+f3}{1'b1}}}:temp_out[i3+f3-1:0];
    end


end

assign out = out_ref;

endmodule

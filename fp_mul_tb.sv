module fp_mul_tb;

  // Parameters
  localparam  i1 = 2;
  localparam  f1 = 14;
  localparam  i2 = 2;
  localparam  f2 = 14;
  localparam  i3 = 3;
  localparam  f3 = 8;

  //Ports
  reg [i1+f1-1 :0] in1;
  reg i_sign1;
  reg [i2+f2-1 :0] in2;
  reg i_sign2;
  wire [i3+f3-1 :0] out;
  wire  overflow;
  wire  underflow;
  wire o_sign;
  fp_mul # (
    .i1(i1),
    .f1(f1),

    .i2(i2),
    .f2(f2),
 
    .i3(i3),
    .f3(f3)
  )
  fp_mul_inst (
    .in1(in1),
        .i_sign1(i_sign1),
    .in2(in2),
       .i_sign2(i_sign2),
       .o_sign(o_sign),
    .out(out),
    .overflow(overflow),
    .underflow(underflow)
  );

//always #5  clk = ! clk ;

integer file;
real rand_num, r_in1, r_in2, r_out, error_mul, error_mul_abs;
real ref_in1,ref_in2,ref_out;
  
initial begin

file = $fopen("out_fp.csv", "w");
  for (integer i = 0; i < 100; i++) begin
  if (file == 0) begin
              $stop("Error in Opening file !!");
          end
  else begin        
  i_sign1=$urandom;
  i_sign2=$urandom;
        if(i_sign1) begin
            r_in1 = rand_float(fp_range_min(i1, f1), fp_range_max(i1, f1));
        end else begin
            r_in1 = rand_float(0, fp_urange_max(i1, f1));
        end   

        if(i_sign2) begin
            r_in2 = rand_float(fp_range_min(i2, f2), fp_range_max(i2, f2));
        end else begin
            r_in2 = rand_float(0, fp_urange_max(i2, f2));
        end        

        r_out = r_in1 * r_in2;
  

        in1 = $rtoi(r_in1 * (2 ** f1));
        in2 = $rtoi(r_in2 * (2 ** f2));
        #1
        if(i_sign1) ref_in1=$signed(in1);
        else ref_in1=in1;
        if(i_sign2) ref_in2=$signed(in2);
        else ref_in2=in2;
        
        if (o_sign)ref_out = $signed(out);
        else ref_out = out;
        
        error_mul = r_out - real'(ref_out/2.0**f3);
        
    
        

        if(error_mul < 0) begin
            error_mul_abs = -error_mul;
        end else begin
            error_mul_abs = error_mul;
        end            
        
   //     $fdisplay(file,"a_ref = %f, b_ref = %f, out_ref = %f, in1 = %f, in2 = %f, out = %f", r_in1, r_in2, r_out, (real'(ref_in1)/2**14), real'(ref_in2/2**14), real'(ref_out/2**14));
           
         if(error_mul_abs > 1e-3) begin
            if (overflow) $fdisplay(file,"op err-----overflow has occured!-----");
            else if (underflow) $fdisplay(file,"op err+++++underflow has occured!+++++");
            else $fdisplay(file,"~~~~~output mismatch~~~~~. error = %f", error_mul_abs);          
        end
        
        else begin
        if (overflow) $fdisplay(file,"-----overflow has occured!-----");
        else if (underflow) $fdisplay(file,"+++++underflow has occured!+++++");
        else $fdisplay(file,"success. precision=%f",error_mul);
        end
      end  
      
end
  $fclose(file);
end

/* generates in1 real value between min and max */
function automatic real rand_float (input real min, max);
    integer unsigned rand_num;
    rand_num = $urandom();
    rand_float = min + (max-min) * (real'(rand_num)/32'hffffffff);
        $display("%f %f %f %f %f", min, max, max-min, (real'(rand_num)/32'hffffffff), rand_float);
endfunction

function real fp_range_min (input integer i, f);
    fp_range_min = -1 * (2.0**(i-1));
endfunction

function real fp_range_max (input integer i, f);
    fp_range_max = 2.0**(i-1) - 2.0**(-f);
endfunction

function real fp_urange_max (input integer i, f);
    fp_urange_max =  2**i - 2.0**(-f);
endfunction




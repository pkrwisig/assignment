module reg_tb(  );
reg  clk;
reg reset;
  
  reg [7:0] input_tdata;
  
reg input_tvalid;
  
reg input_tlast;
  
reg output_tready;
  
  
  wire input_tready,output_tvalid,output_tlast;
  
  wire [7:0] output_tdata;
  
  
  
register        dut(clk,reset,input_tdata,input_tvalid,input_tlast,input_tready,output_tvalid,output_tdata,output_tlast,output_tready);
  
  initial begin
      begin
      clk = 0;
      input_tlast = 0;
        @(posedge clk) reset = 1;
            @(posedge clk)
                begin
                    reset <= 0;
                    output_tready <= 1;
                    input_tvalid <= 1;
                    input_tdata <= 2;
                end
                @(posedge clk) begin
                    output_tready <= 0;
                    input_tvalid <= 1;
                    input_tdata <= 3;
                end
                @(posedge clk) begin
                    output_tready <= 1;
                    input_tvalid <= 0;
                    input_tdata <= 4;
                end
                @(posedge clk) begin
                    output_tready <= 1;
                    input_tvalid <= 1;
                    input_tdata <= 5;
                end

            @(posedge clk) begin
                output_tready <= 0;
                input_tvalid <= 1;
                input_tdata <= 6;
                input_tlast <= 1;
            end
            repeat(10) @(posedge clk);
            $finish;
        end
    end

    always
        #5  clk = ! clk ;
  /*always   #5 clk = ~clk;
  
  initial begin
  clk<=0;
  reset <=1;
  input_tdata<=0;
  input_tvalid<=0;
  input_tlast<=0;
  output_tready<=0;
  end 
  
  
    /* task rst;
  begin
  reset = 1 ;
  #50
  reset =0;
  end 
  
  endtask
  
  task stimulus;
  input [7:0] data;
  begin
  input_tdata = data;
  input_tvalid = 1;
  
  #20 
  input_tvalid =0 ;
  end
  endtask
  
  initial begin
  
  rst;
  output_tready =1;
  repeat(3)begin
  repeat(5)begin
  input_tlast=0;
  stimulus($random);
  
  @(posedge clk);
  end
  input_tlast=1;
  stimulus($random);
   
  @(posedge clk);
  
 #10;

  end
 


     
        
   $finish; 
end
  initial begin
  $monitor ("clk=%0b,reset=%0b,input_tdata=%0h,input_tvalid=%b0,input_tlast=%b,input_tready=%0b,output_tvalid=%0b,output_tdata=%0h,output_tlast=%0b,output_tready=%0b",clk,reset,input_tdata,input_tvalid,input_tlast,input_tready,output_tvalid,output_tdata,output_tlast,output_tready);
  end 

    

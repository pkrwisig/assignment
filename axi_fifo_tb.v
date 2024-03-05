module axi_fifo_tb( );
  reg                   clk,rst,w_en,r_en;
  

  reg [5:0]             in_tdata;
  reg                   in_tvalid;
  reg                   in_tlast;
  wire                  in_tredady;

  wire  [5:0]        o_tdata;
  wire               o_tvalid;
  wire                o_tlast;
  reg                   o_tredady;

  reg                   full, empty;
  
  axi_fifo dut (clk,rst,w_en,r_en,in_tdata,in_tvalid,in_tlast,in_tredady,o_tdata,o_tvalid,o_tlast,o_tredady);
  
  
  always #5 clk = ~clk ;
  
  
  initial begin
  clk<=0;
        rst<=1;
        w_en<=0;
        r_en<=0;
        in_tdata<=0;
        in_tvalid<=0;
        in_tlast<=0;
        
        o_tredady<=1;
      

  end
  
  
  initial begin
      
  repeat(10)begin
           /*  rst=0;
             full=1;
            w_en <= 1;
            in_tvalid <= 1;
            in_tdata <= $urandom;
           #20  r_en <=1;
            @(posedge clk);
            end */
            
            
           
           
            
            #10; // Wait for 10 ns
            rst <= 0;
            // Write data to FIFO
            w_en <= 1;
            in_tvalid <= 1;
            in_tdata <= $urandom;
            
            #20; // Wait for 20 ns
            // Read data from FIFO
            w_en <= 0;
            in_tvalid <= 0;
            r_en <= 1;
            #20; // Wait for 20 ns
            // Reset for the next iteration
            rst <= 1;
            w_en <= 0;
            r_en <= 0;
            in_tvalid <= 0;
            #20; // Wait for 100 ns
            @(posedge clk);
        end
        
        #600;
       
        
            // Finish simulation
        
       
        
        $finish;
    end
  
  

  
  
  initial begin
  $monitor(" clk=%b,rst=%b,w_en = %b,r_en = %b,in_tdata= %b,in_tvalid= %b,in_tlast= %b,in_tredady= %b,o_tdata= %b,o_tvalid= %b,o_tlast= %b,o_tredady= %b,full= %b,empty== %b",clk,rst,w_en,r_en,in_tdata,in_tvalid,in_tlast,in_tredady,o_tdata,o_tvalid,o_tlast,o_tredady,full,empty);
  end
  

  
  
endmodule

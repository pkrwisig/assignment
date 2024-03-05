module axi_mux_tb( );
       reg              clk,rst;

    reg[7:0]          i_tdata0;
    reg                i_tvalid0;
    reg               i_tlast0;
    wire              i_tready0;

    reg[7:0]          i_tdata1;
    reg               i_tvalid1;
    reg               i_tlast1;
    wire              i_tready1;


    reg              i_tsel;
    reg               i_tsel_valid;
    wire              i_tsel_ready;

    wire [7:0]      o_tdata;
    wire            o_tvalid;
    wire           o_tlast;
    reg                o_tready;

   
    axi_mux    dut(clk,rst,i_tdata0,i_tvalid0,i_tlast0,i_tready0,i_tdata1,i_tvalid1,i_tlast1,i_tready1,
        i_tsel,i_tsel_valid,i_tsel_ready,o_tdata,o_tvalid,o_tlast,o_tready);

    always #5 clk = ~clk ;

   /* initial begin
        clk<=0;
        rst<=1;
        i_tdata0<=0;
        i_tvalid0<=0;
        i_tlast0<=0;
        i_tdata1<=0;
        i_tvalid1<=0;
        i_tlast1<=0;
       
        i_tsel<=0;
        i_tsel_valid<=0;
        o_tready<=0; */



  /*  initial begin
       #15 rst = 0;
       
       #10 
       o_tready<=1;
       
       #10
        i_tsel_valid<=1;
        i_tsel<=0;

       i_tvalid0<=1;
       i_tdata0<=8'h33;


       #30 
       o_tready<=0;
       
       
       #20
       o_tready<=1;

       #20
       i_tvalid0<=0;
       
        i_tvalid1<=1;
        i_tdata1<=8'h55;
        
        #10
        i_tsel_valid<=1;
        i_tsel<=1;

        #20
        i_tsel<=1;
        

        #30
        o_tready<=0; 

        $finish; 

     

    end
*/

 initial begin
        // Initialize inputs
        
        clk = 0;
        rst = 1;
        i_tdata0 = 8'b00000000;
        i_tvalid0 = 0;
        i_tlast0 = 0;
        i_tdata1 = 8'b11111111;
        i_tvalid1 = 0;
        i_tlast1 = 0;
        i_tsel = 0;
        i_tsel_valid = 0; 
                  o_tready = 0;
        #150; 
        
     
        rst = 0;

       
        i_tsel = 0;
        i_tvalid0 = 1;
        i_tdata0 = $urandom;
        #15 i_tdata0 = $urandom;
       #15 i_tdata0 = $urandom;
        #15i_tdata0 = 8'd11;
        i_tlast0 = 1;
         #10 i_tlast0 = 0;
        o_tready = 0;
        #10 o_tready = 1;
        #100; 
        
        i_tsel = 1;
        i_tvalid1 = 1;
        i_tdata1 = $urandom;
        #15i_tdata1 = $urandom;
        #15i_tdata0 = $urandom;
        #15i_tdata0 = 8'd15;
        i_tlast1 = 1;
        #15i_tlast1 = 0;
        #10o_tready = 0;
        #20 o_tready = 1;
        
         
       
       

        $finish; // Finish simulation
  end
    initial begin  
$monitor("clk=%0b,rst=%0b,i_tdata0=%0h,i_tvalid0=%0b,i_tlast0=%0b,i_tready0=%0b,i_tdata1=%0h,i_tvalid1=%0b,i_tlast1=%0b,i_tready1=%0b,i_tsel=%0b,i_tsel_valid=%0b,i_tsel_ready=%0b,o_tdata=%0h,o_tvalid=%0b,o_tlast=%0b,o_tready=%0b",clk,rst,i_tdata0,i_tvalid0,i_tlast0,i_tready0,i_tdata1,i_tvalid1,i_tlast1,i_tready1,
i_tsel,i_tsel_valid,i_tsel_ready,o_tdata,o_tvalid,o_tlast,o_tready);
    end
    
endmodule

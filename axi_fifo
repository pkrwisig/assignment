module axi_fifo  (
  input                   clk,
  input                   rst,
  input                   w_en,
  input                   r_en,

  input [7:0]             in_tdata,
  input                   in_tvalid,
  input                   in_tlast,
  output                  in_tredady,

  output  [7:0]        o_tdata,
  output               o_tvalid,
  output                o_tlast,
  input                   o_tredady

  //output  reg                 full, empty
);
  reg  full ,empty ;
   reg [11:0]      w_ptr; 
   reg [11: 0]     r_ptr;
   reg [11:0]      fifo_counter;


   reg  [7:0]  fifo_mem[2047:0];   
   reg             fifo_last;         // width 8 depth 2048
   reg [7:0]       temp_in,temp_out    ;
   reg                 temp_last;
   
reg fifo_valid;
reg temp_valid;


assign in_tredady= o_tredady & ~ rst;

assign o_tvalid =in_tvalid;
assign o_tlast = in_tlast;
   //counter logic
   always@(posedge clk)begin
    if( rst )
       fifo_counter <= 0;
    else if( (!full && w_en && in_tvalid ) && ( !empty && r_en && o_tredady ))
        fifo_counter<=fifo_counter;
        else if (!full && w_en && in_tvalid )
            fifo_counter<=fifo_counter+1;
    else if ( !empty && r_en && o_tredady && in_tvalid )
        fifo_counter<=fifo_counter-1;
    else 
        fifo_counter<=fifo_counter;

   end

   //full and empty condition
    
   always@(fifo_counter)begin
           
         empty= (fifo_counter==0);
         full = (fifo_counter==2047);
   end
   
   // pointer
   
   always@(posedge clk) begin 
    if (rst)begin
        w_ptr <= 0;
        r_ptr <= 0;
        end
      else if(in_tvalid  &&  w_en && !full )
        w_ptr <= w_ptr + 1;
      else if(o_tredady  && r_en && !empty )
        r_ptr <= r_ptr + 1;
        
      else
        w_ptr <= w_ptr;
        r_ptr <= w_ptr;
 
   end

 

  
  // Iinput side To write data to FIFO
  always@(posedge clk) begin 
   

     if(in_tvalid  &&  w_en && !full )begin
      fifo_mem[w_ptr] <= in_tdata ;
       // fifo_last <=in_tlast;
        //fifo_valid <= in_tvalid;
       end

    else  fifo_mem[w_ptr]<=fifo_mem[w_ptr];
          //fifo_valid <= fifo_valid ;
          //fifo_last <= fifo_last ;

     end
  
  // output side To read data from FIFO
  always@(posedge clk) begin
    if(rst) begin
        w_ptr <= 0; r_ptr <= 0;
        
  
        //fifo_mem<=0;
      
      end
    else if(o_tredady  && r_en && !empty ) begin
        temp_out <= fifo_mem[r_ptr];
        // temp_last<=fifo_last;
         //temp_valid <= fifo_valid;
          end

        else begin
      temp_out <= temp_out ;
     // temp_last <= temp_last;
      //temp_valid <= temp_valid ;
        end
      

  end
  
  
  assign o_tdata = temp_out;
  
  //assign o_tvalid = temp_valid ;
  
   //assign o_tlast = temp_last; 
  
  
endmodule

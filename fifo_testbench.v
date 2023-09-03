`timescale 1ns / 1ps



module fifo_tb();
parameter depth = 8; 
parameter width = 8; 
reg clk, rst, w_en, r_en ;
reg[width-1:0] data_in;
reg[width-1:0] tempdata;
wire [width-1:0] data_out;
wire [3:0] fifo_cnt;

fifo dut( .clk(clk), .rst(rst), .data_in(data_in), .data_out(data_out), 
         .w_en(w_en), .r_en(r_en), .empty(empty), 
         .full(full), .fifo_cnt(fifo_cnt) );

initial
begin
   clk = 0;
   rst = 1;
        r_en= 0;
        w_en = 0;
        tempdata = 0;
        data_in = 0;


        #15 rst = 0;
  
        push(1);
        fork
           push(2);
           pop(tempdata);
        join              //push and pop together   
        push(4);
        push(5);
        push(6);
        push(7);
        push(8);
        push(9);
        push(1);
        push(2);
        push(4);
        push(8);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        push(16);
        push(32);
        push(64);

        pop(tempdata);
        push(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
		  push(140);
        pop(tempdata);
        push(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
end

always
   #5 clk = ~clk;

task push;
input[7:0] data;


   if( full )
     $display("FIFO is full,cannot push further");
        else begin
           $display("Pushed ",data );
           data_in = data;
           w_en= 1;
                @(posedge clk);
                #1 w_en = 0;
        end
endtask

task pop;
output [7:0] data;

   if( empty )
     $display("FIFO is empty cannot pop further");
   else
        begin
     r_en = 1;
          @(posedge clk);
          #1 r_en = 0;
          data = data_out;
           $display("--Poped ", data);

        end
endtask
initial begin 
    $dumpfile("dump.vcd");
     $dumpvars;
  end

endmodule

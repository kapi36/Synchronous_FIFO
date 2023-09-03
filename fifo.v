`timescale 1ns / 1ps


module fifo(data_in,clk, rst, r_en, w_en,empty, full,fifo_cnt,data_out);

parameter depth = 8 ; 
parameter width = 8 ; 
input [width-1:0] data_in; 
input clk, rst, r_en, w_en; 
output empty, full; 
output reg [3:0]fifo_cnt; 
output reg [width-1:0] data_out;


reg [width-1:0] fifo [0:depth-1]; // defining fifo structure
reg [$clog2(depth)-1:0]rd_ptr; 
reg [$clog2(depth)-1:0]wr_ptr;

assign empty= (fifo_cnt==0);
assign full =(fifo_cnt==8);

always @(posedge clk) begin: write
if (w_en && ! full)begin 
fifo[wr_ptr] <= data_in;
wr_ptr = wr_ptr+1;
end 
else if (w_en && r_en)begin
fifo[wr_ptr] <= data_in;
wr_ptr=  wr_ptr+1; 
end
end

//Read and Write Clock
always @ (posedge clk) begin: read
if (r_en && !empty)begin
data_out <= fifo [rd_ptr];
rd_ptr = rd_ptr+1; 
end
else if (r_en && w_en)begin
data_out <= fifo[rd_ptr];
rd_ptr = rd_ptr+1; 
end
end



//pointer block
always @(posedge clk) begin: pointer
if (rst) begin
wr_ptr <= 0;
rd_ptr <= 0;
end 
//else begin
//wr_ptr <= ((wr && ! full) || (wr && rd)) ? wr_ptr+1 :
//wr_ptr;
//rd_ptr <= ((rd && !empty) || (wr && rd)) ? rd_ptr+1:
//rd_ptr;
//end
end

//counter
always @(posedge clk) begin: count
if (rst) fifo_cnt <= 0;
else begin
case ({w_en, r_en})
2'b00: fifo_cnt <= fifo_cnt;
2'b01: fifo_cnt <= (fifo_cnt==0) ? 0: fifo_cnt-1;
2'b10: fifo_cnt <= (fifo_cnt==8) ? 8: fifo_cnt+1;
2'b11 : fifo_cnt <= fifo_cnt;
default: fifo_cnt <= fifo_cnt;
endcase
end
end
endmodule

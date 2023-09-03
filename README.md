# Synchronous_FIFO
Designed synchronous_FIFO using verilog with help of icrus_verilog and gtkwave on ubuntu


					Synchronous FIFO


FIFO : 
First in First out it is a very popular and useful design for the purpose of synchronization. 

Depth of FIFO: The number of slots or rows in FIFO is called the depth of the FIFO. 

Width of FIFO: The number of bits that can be stored in each slot or row is called the width of the FIFO. 


Synchronous FIFO: 
In synchronous FIFO data read and write operations use the same clock frequency. Also the frequency used is high clock frequency to support a high speed system. 




w_en : write enable ,input pin
w_ptr : write address pointer
w_data:  write data
full : FIFO is full  with words ,output pin
r_en : Read enable ,input pin
empty: FIFO is empty, output pin
rst_n:  reset the FIFO Complete data is set zero
r_data: read data


FIFO write operation: FIFO can write the data on the bits when posedge comes and w_en is 1. and till it is full And also the w_ptr is increment at every writing 

FIFO read Operation: FIFO can read the data when posedge comes and r_en is on and read till its empty. r_ptr gets incremented on every data read from FIFO memory. 






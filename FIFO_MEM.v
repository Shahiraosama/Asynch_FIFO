module FIFO_MEM #(parameter WIDTH = 8 , parameter ADDRESS = 3 ,parameter DEPTH = 8 ) (

input	wire					W_CLK,
input	wire					W_RST,
input	wire	[WIDTH-1:0]			W_DATA,
input	wire					W_INC,
input	wire					W_FULL,
input	wire	[ADDRESS-1:0]			W_ADDR,
input	wire	[ADDRESS-1:0]			R_ADDR,
output	wire	[WIDTH-1:0]			R_DATA

);

reg [DEPTH-1:0] i ;
reg		[WIDTH-1:0]		fifo_mem	[0:DEPTH-1];

always@(posedge W_CLK or negedge W_RST )
begin
if(!W_RST)
begin

for(i = 0 ; i< DEPTH ; i = i+1)
begin
fifo_mem [i] <= {WIDTH{1'b0}};
end

end

 if (W_INC && !W_FULL)
begin

fifo_mem [W_ADDR] <= W_DATA ; 

end


end

assign R_DATA = fifo_mem [R_ADDR] ;

endmodule
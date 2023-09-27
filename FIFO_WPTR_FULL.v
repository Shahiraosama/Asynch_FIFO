module FIFO_FULL #(parameter ADDRESS = 3) (

input	wire			W_INC,
input	wire			W_CLK,
input	wire			W_RST,
input	wire	[ADDRESS:0]	WQ2_RPTR,
output	wire	[ADDRESS-1:0]	W_ADDR,
output	reg	[ADDRESS:0]	W_PTR,
output	reg			W_FULL


);

wire						w_full ;

wire			[ADDRESS:0]		gray_wr_ptr;

reg			[ADDRESS:0]		binary_ptr;

wire			[ADDRESS:0] 		binary_ptr_next;


assign w_full = (gray_wr_ptr[ADDRESS]!= WQ2_RPTR[ADDRESS]) && (gray_wr_ptr[ADDRESS-1]!= WQ2_RPTR[ADDRESS-1]) && (gray_wr_ptr[ADDRESS-2:0] == WQ2_RPTR[ADDRESS-2:0]);

assign binary_ptr_next = (W_INC && !W_FULL) ? binary_ptr + 1 : binary_ptr ;


always@(posedge W_CLK or negedge W_RST)

begin

if(!W_RST)
begin


W_PTR <= 'b0;
binary_ptr <= 'b0;

end

else 
begin

binary_ptr <= binary_ptr_next ;
W_PTR <= gray_wr_ptr ;

end


end


always@(posedge W_CLK or negedge W_RST)

begin

if(!W_RST)
begin


W_FULL <= 'b0;

end

else 
begin

W_FULL <= w_full ; 

end


end

// to convert binary code to gray code 
// 1- we have to keep the MSB as it's 
// 2- we xoring binary code bit at that index and previous index.

// 100110 
// 010011
// -------
// 110101 

assign gray_wr_ptr = (binary_ptr_next >> 1) ^ binary_ptr_next ;

assign W_ADDR = binary_ptr[ADDRESS-1:0] ; 

endmodule

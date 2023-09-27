module FIFO_EMPTY #(parameter ADDRESS = 3) (
input	wire			R_INC,
input	wire			R_CLK,
input	wire			R_RST,
input	wire	[ADDRESS:0]	RQ2_WPTR,
output	wire	[ADDRESS-1:0]	R_ADDR,
output	reg	[ADDRESS:0]	R_PTR,
output	reg			R_EMPTY

);

wire		[ADDRESS:0]			gray_rd_ptr;
reg		[ADDRESS:0]			binary_ptr;
wire		[ADDRESS:0]			binary_ptr_next;
		

assign r_empty = (gray_rd_ptr == RQ2_WPTR)? 1'b1 : 1'b0 ;

assign binary_ptr_next = (R_INC && !R_EMPTY)  ? binary_ptr + 1'b1 : binary_ptr ;



always@(posedge R_CLK  or negedge R_RST)
begin
if(!R_RST)
begin

R_PTR <= 'b0 ;
binary_ptr <= 'b0 ;

end

else
begin

binary_ptr <= binary_ptr_next ;
R_PTR <= gray_rd_ptr;


end


end

always@(posedge R_CLK  or negedge R_RST)
begin
if(!R_RST)
begin


R_EMPTY <= 'b1 ;


end

else
begin

R_EMPTY <= r_empty ;

end


end

assign gray_rd_ptr =  binary_ptr_next ^ (binary_ptr_next >> 1);
assign R_ADDR = binary_ptr[ADDRESS-1:0] ;

endmodule
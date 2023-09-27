module FIFO #(parameter WIDTH = 8 , parameter ADDRESS = 3 , parameter DEPTH = 8) (

input	wire			W_CLK,
input	wire			W_RST,
input	wire			W_INC,
input	wire			R_CLK,
input	wire			R_RST,
input	wire			R_INC,
input	wire	[WIDTH-1:0]	WR_DATA,

output				FULL,
output				EMPTY,
output		[WIDTH-1:0]	RD_DATA

);

wire	[ADDRESS:0]	wq2_rptr;
wire	[ADDRESS-1:0]	w_addr;
wire	[ADDRESS:0]	w_ptr;
wire	[ADDRESS:0]	rq2_wptr;
wire	[ADDRESS-1:0]	r_addr;
wire	[ADDRESS:0]	r_ptr;


FIFO_FULL  #(.ADDRESS(ADDRESS)) full_unit (.W_CLK(W_CLK),.W_INC(W_INC),.W_RST(W_RST),.WQ2_RPTR(wq2_rptr),.W_ADDR(w_addr),.W_PTR(w_ptr),.W_FULL(FULL));

FIFO_EMPTY  #(.ADDRESS(ADDRESS)) empty_unit (.R_CLK(R_CLK),.R_INC(R_INC),.R_RST(R_RST),.RQ2_WPTR(rq2_wptr),.R_ADDR(r_addr),.R_PTR(r_ptr),.R_EMPTY(EMPTY));

FIFO_MEM #(.WIDTH(WIDTH),.ADDRESS(ADDRESS),.DEPTH(DEPTH)) mem_unit (.W_CLK(W_CLK),.W_RST(W_RST),.W_DATA(WR_DATA),.W_INC(W_INC),.W_FULL(FULL),.W_ADDR(w_addr),.R_ADDR(r_addr),.R_DATA(RD_DATA));

BIT_SYNC  #(.WIDTH(ADDRESS+1),.STAGES(2)) bit_sync_1 (.ASYNC(r_ptr),.CLK(W_CLK),.RST(W_RST),.SYNC(wq2_rptr));

BIT_SYNC  #(.WIDTH(ADDRESS+1),.STAGES(2)) bit_sync_2 (.ASYNC(w_ptr),.CLK(R_CLK),.RST(R_RST),.SYNC(rq2_wptr));


endmodule

`timescale 1ns/1ps ;
module FIFO_TB;

parameter	WIDTH = 8;
parameter	DEPTH = 8;
parameter	ADDRESS = 3;


reg			W_CLK_TB;
reg			W_RST_TB;
reg			W_INC_TB;
reg			R_CLK_TB;
reg			R_RST_TB;
reg			R_INC_TB;
reg	[WIDTH-1:0]	WR_DATA_TB;

wire			FULL_TB;
wire			EMPTY_TB;
wire	[WIDTH-1:0]	RD_DATA_TB;

localparam WR_CLK = 10;
localparam RD_CLK = 25;
integer i;
integer j;

FIFO #(.WIDTH(WIDTH),.ADDRESS(ADDRESS),.DEPTH(DEPTH)) DUT (
.W_CLK(W_CLK_TB),.W_RST(W_RST_TB),.W_INC(W_INC_TB),
.R_CLK(R_CLK_TB),.R_RST(R_RST_TB),.R_INC(R_INC_TB),
.WR_DATA(WR_DATA_TB),.FULL(FULL_TB),.EMPTY(EMPTY_TB),
.RD_DATA(RD_DATA_TB)

);

always
begin
#(WR_CLK/2.0) W_CLK_TB = ~W_CLK_TB;
end


always
begin
#(RD_CLK/2.0)	R_CLK_TB = ~R_CLK_TB ;
end

//reg	[WIDTH-1:0]	DATA	[0:DEPTH-1];

initial
begin

//$readmemh("DATA.txt",DATA) ;

W_CLK_TB = 'b0;
W_RST_TB = 'b0;
R_CLK_TB = 'b0;
R_RST_TB = 'b0;
W_INC_TB = 'b0;
R_INC_TB = 'b0;



#(10);
W_RST_TB = 'b1;
R_RST_TB = 'b1;


for (i=0;i<8;i=i+1) 
begin
	W_INC_TB = 1;
	WR_DATA_TB = i**2;
	#(WR_CLK);
	W_INC_TB = 0;
	#(WR_CLK);
end
end


initial 
begin
#50;
for (j=0 ; j<3 ; j=j+1) begin
	R_INC_TB  =1;
	#(RD_CLK);
	R_INC_TB = 0;
	#(RD_CLK);
end

#750;

for (j=0;j<3;j=j+1) begin
	R_INC_TB =1;
	#(RD_CLK);
	//R_INC_TB = 0;
	//#(RD_CLK);
end
end

initial
begin

#(2000*(WR_CLK));
$stop;

end

 



endmodule


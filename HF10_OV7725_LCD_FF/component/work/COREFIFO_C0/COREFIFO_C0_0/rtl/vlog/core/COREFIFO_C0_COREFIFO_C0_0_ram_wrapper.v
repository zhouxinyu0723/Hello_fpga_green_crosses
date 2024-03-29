// This is automatically generated file 

`timescale 1 ns/100 ps
module COREFIFO_C0_COREFIFO_C0_0_ram_wrapper(
WDATA,  
WADDR,  
WEN,    
REN,    
RDATA,  
RADDR,  
RESET_N,
CLOCK,  
WCLOCK, 
A_SB_CORRECT, 
B_SB_CORRECT, 
A_DB_DETECT, 
B_DB_DETECT, 
RCLOCK  
);      
  

// --------------------------------------------------------------------------
// PARAMETER Declaration
// --------------------------------------------------------------------------
parameter                RWIDTH        = 32;  // Read  port Data Width
parameter                WWIDTH        = 32;  // Write port Data Width
parameter                RDEPTH        = 128; // Read  port Data Depth
parameter                WDEPTH        = 128; // Write port Data Depth
parameter                SYNC          = 0;   // Synchronous or Asynchronous operation | 1 - Single Clock, 0 - Dual clock
parameter                SYNC_RESET    = 0;   // Synchronous or Asynchronous Reset | 1 - Synchronous Reset, 0 - Asynchronous Reset
parameter                RAM_OPT    	= 0;   //  |  0 -High Speed , 1 - Low Power
parameter                PIPE          = 1;   // Pipeline read data out
parameter                CTRL_TYPE     = 1;   // Controller only options | 1 - Controller Only, 2 - RAM1Kx18, 3 - RAM64x18
// --------------------------------------------------------------------------
// I/O Declaration
// --------------------------------------------------------------------------
input [WWIDTH - 1 : 0]   WDATA;  
input [(WDEPTH - 1) : 0] WADDR;  
input                    WEN;    
input                    REN;    
output [RWIDTH - 1 : 0]  RDATA;  
input [(RDEPTH - 1) : 0] RADDR;  
input                    RESET_N;
output                   A_SB_CORRECT; 
output                   B_SB_CORRECT; 
output                   A_DB_DETECT; 
output                   B_DB_DETECT; 
input                    WCLOCK; 
input                    RCLOCK; 
input                    CLOCK;  
  

COREFIFO_C0_COREFIFO_C0_0_USRAM_top U5_syncnonpipe (
.A_DOUT        (RDATA       ),
.B_DOUT        (            ),
.C_DIN         (WDATA       ),
.A_ADDR        (RADDR       ),
.B_ADDR        (RADDR       ),
.C_ADDR        (WADDR       ),
.A_BLK         (REN         ),
.B_BLK         (REN         ),
.C_BLK         (1'b1        ),
.C_WEN         (WEN         ),
.CLK           (CLOCK       ),
.A_ADDR_EN     (REN         ),
.A_ADDR_SRST_N (RESET_N     ),
.B_ADDR_SRST_N (RESET_N    ),
.B_ADDR_EN     (REN         )
);


endmodule

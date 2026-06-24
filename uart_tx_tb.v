`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 02:18:10
// Design Name: 
// Module Name: uart_tx_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module uart_tx_tb;

reg clk;
reg reset;
reg tx_start;
reg [7:0] data_in;

wire tx;
wire tx_done;

uart_tx uut(
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .data_in(data_in),
    .tx(tx),
    .tx_done(tx_done)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;
    tx_start = 0;
    data_in = 8'b0;

    #10;
    reset = 0;

    // Send 10101010
    #10;
    data_in = 8'b10101010;
    tx_start = 1;

    #10;
    tx_start = 0;

    #150;

    // Send 11001100
    data_in = 8'b11001100;
    tx_start = 1;

    #10;
    tx_start = 0;

    #150;

    $finish;
end

endmodule

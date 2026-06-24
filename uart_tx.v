`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 02:17:55
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
    input clk,
    input reset,
    input tx_start,
    input [7:0] data_in,
    output reg tx,
    output reg tx_done
);

reg [3:0] bit_count;
reg [9:0] shift_reg;
reg transmitting;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        tx <= 1'b1;
        tx_done <= 0;
        bit_count <= 0;
        transmitting <= 0;
        shift_reg <= 10'b1111111111;
    end
    else
    begin
        tx_done <= 0;

        if(tx_start && !transmitting)
        begin
            // Stop bit + Data + Start bit
            shift_reg <= {1'b1, data_in, 1'b0};
            transmitting <= 1;
            bit_count <= 0;
        end
        else if(transmitting)
        begin
            tx <= shift_reg[0];
            shift_reg <= shift_reg >> 1;
            bit_count <= bit_count + 1;

            if(bit_count == 9)
            begin
                transmitting <= 0;
                tx_done <= 1;
                tx <= 1'b1;
            end
        end
    end
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2025 12:35:38
// Design Name: 
// Module Name: mux_demo
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



module mux_demo(A, B, C, S, out);
input [7:0] A, B, C;
input [2:0] S;
output reg [7:0] out;

always@(*) begin
    case (S)
    3'b111, 3'b110 : out=A;
    3'b001, 3'b011 : out=B;
    3'b000, 3'b100 : out=C;
    default out=4'bx;
    endcase
  end
endmodule 

module mux_demo_tb();
reg [7:0] A, B, C;
reg [2:0] S;
wire [7:0] out;

mux_demo dut(.A(A), .B(B), .C(C), .S(S), .out(out));
initial begin 
    #5 S= 3'b000;A= 8'd5; B= 8'd11; C= 8'd15;
    #5 S= 3'b001;A= 8'd5; B= 8'd11; C= 8'd15;
    #5 S= 3'b010;A= 8'd5; B= 8'd11; C= 8'd15;
    #5 S= 3'b011;A= 8'd5; B= 8'd11; C= 8'd15;
    #5 S= 3'b100;A= 8'd5; B= 8'd11; C= 8'd15;
    #5 S= 3'b101;A= 8'd5; B= 8'd11; C= 8'd15;
    #5 S= 3'b110;A= 8'd5; B= 8'd11; C= 8'd15;
    #5 S= 3'b111;A= 8'd5; B= 8'd11; C= 8'd15;
    #5 $finish;
    end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2025 10:13:32
// Design Name: 
// Module Name: comparator
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


module comparator( X, Y, max);
input [7:0] X, Y;
output reg max;

always @(*) begin
    max = (X > Y) ? 1'b1 : 1'b0;
    end
endmodule

//mux for max number
module mux_max(A, B, C, S, out);
input [7:0] A, B, C;
input [2:0] S;
output reg [7:0] out;

always@(*) begin
    case (S)
    3'b111, 3'b110 : out=A;
    3'b001, 3'b011 : out=B;
    3'b000, 3'b100 : out=C;
    default: begin out=8'b00000000; end
    endcase
  end
endmodule

// mux for mid value
module mux_mid(A, B, C, S, out);
input [7:0] A, B, C;
input [2:0] S;
output reg [7:0] out;

always@(*) begin
    case (S)
    3'b100, 3'b011 : out=A;
    3'b000, 3'b111 : out=B;
    3'b001, 3'b110 : out=C;
    default out=8'd0;
    endcase
  end
endmodule

//mux for min value
module mux_min(A, B, C, S, out);
input [7:0] A, B, C;
input [2:0] S;
output reg [7:0] out;

always@(*) begin
    case (S)
    3'b000, 3'b001 : out=A;
    3'b100, 3'b110 : out=B;
    3'b011, 3'b111 : out=C;
    default out=8'd0;
    endcase
  end
endmodule


module CS(A,B,C, Max, Mid, Min);
input [7:0] A, B, C;
output [7:0] Max, Mid, Min;
wire S0, S1, S2;

comparator C1(A, B, S2);
comparator C2(A, C, S1);
comparator C3(B, C, S0);

mux_max A1(.S({S2,S1,S0}), .A(A), .B(B), .C(C), .out(Max));
mux_mid A2(.S({S2,S1,S0}), .A(A), .B(B), .C(C), .out(Mid));
mux_min A3(.S({S2,S1,S0}), .A(A), .B(B), .C(C), .out(Min));

endmodule

/////////////////////////////////////////////////////////////////////////////////
//tb_for_CS

//module CS_demo_tb();
//reg [7:0] A, B, C;
//wire [7:0] Max, Mid, Min;

//CS dut(.A(A), .B(B), .C(C), .Max(Max), .Mid(Mid), .Min(Min));

//initial begin
//#5 A= 8'd6; B= 8'd48; C= 8'd25;
//#5 $finish;
//end 
//endmodule
//////////////////////////////////////////////////////////////////////////////////

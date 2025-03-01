`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2025 19:27:08
// Design Name: 
// Module Name: median_filter
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


// **W 3X3 filter**
module median_filter( P1, P2, P3, P4, P5, P6, P7, P8, P9, Mid);

input [7:0] P1, P2, P3, P4, P5, P6, P7, P8, P9;
output [7:0] Mid;
wire [7:0] CS1_max, CS1_mid, CS1_min, CS2_max, CS2_mid, CS2_min, CS3_max, CS3_mid, CS3_min, CS4_max, CS4_mid, CS4_min, CS5_max, CS5_mid,  CS5_min, CS6_max, CS6_mid, CS6_min, CS7_max, CS7_min;

CS C1(P1, P2, P3, CS1_max, CS1_mid, CS1_min);
CS C2(P4, P5, P6, CS2_max, CS2_mid, CS2_min);
CS C3(P7, P8, P9, CS3_max, CS3_mid, CS3_min);

CS C4(CS1_max, CS2_max, CS3_max, CS4_max, CS4_mid, CS4_min);
CS C5(CS1_mid, CS2_mid, CS3_mid, CS5_max, CS5_mid, CS5_min);
CS C6(CS1_min, CS2_min, CS3_min, CS6_max, CS6_mid, CS6_min );

CS C7(CS4_min, CS5_mid, CS6_max, CS7_max, Mid, CS7_min);

endmodule



//Testbench-- for median calculation:
//module median_filter_tb();
//reg [7:0] P1, P2, P3, P4, P5, P6, P7, P8, P9;
//wire [7:0] Mid;

//median_filter dut(.P1(P1), .P2(P2), .P3(P3), .P4(P4), .P5(P5), .P6(P6), .P7(P7), .P8(P8), .P9(P9), .Mid(Mid));

//initial 
//begin
//#5 P1= 8'd15; P2= 8'd7; P3= 8'd8; P4= 8'd16; P5=8'd21; P6= 8'd22; P7= 8'd25; P8= 8'd28; P9= 8'd43;
//$display(" %d Mid value", Mid);
//#5 $finish;
//end
//endmodule


// 5 val sorting block
module FVS(A, B, C, D, E, M1, M2, M3, M4, M5);
input [7:0] A, B, C, D, E;
output [7:0] M1, M2, M3, M4, M5;
wire [7:0] x1, x2, x3, x4, x5, x7, x8;  
CS A1(C,D,E, x1, x2, x3);
CS A2(A, B, x3, x4, x5, M5);
CS A3(x4, x5, x2, x7, x8, M4);
CS A4(x7, x8, x1, M1, M2, M3);
endmodule





// 5X5 filter architecture

module filter5(input [7:0] P1, P2, P3, P4, P5, P6, P7, P8, P9,P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23, P24, P25, output [7:0] Mid);
wire [7:0] t1, t2, t3, t4, t5,t6,t7,t8,t9,t10, t11,t12, t13, t14, t15,t16,t17,t18,t19,t20 , t21, t22, t23, t24, t25, T1,  T2,  T3,  T4,  T5, T6,  T7,  T8,  T9,  T10, T11, T12, T13, T14, T15,T16, T17, T18, T19, T20, T21, T22, T23, T24, T25, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11,y12,y13,y14,y15  ;
wire [7:0] High, Low;
//Row sorting
FVS R1(P1,  P2,  P3,  P4,  P5,  t1,  t2,  t3,  t4,  t5);
FVS R2(P6,  P7,  P8,  P9,  P10, t6,  t7,  t8,  t9,  t10);
FVS R3(P11, P12, P13, P14, P15, t11, t12, t13, t14, t15);
FVS R4(P16, P17, P18, P19, P20, t16, t17, t18, t19, t20);
FVS R5(P21, P22, P23, P24, P25, t21, t22, t23, t24, t25);

//column sorting
FVS C1(t1, t6,  t11, t16, t21,  T1,  T2,  T3,  T4,  T5);
FVS C2(t2, t7,  t12, t17, t22,  T6,  T7,  T8,  T9,  T10);
FVS C3(t3, t8,  t13, t18, t23,  T11, T12, T13, T14, T15);
FVS C4(t4, t9,  t14, t19, t24,  T16, T17, T18, T19, T20);
FVS C5(t5, t10, t15, t20, t25,  T21, T22, T23, T24, T25);

//Diagonal sorting
FVS D1(8'd255, T4, T8, T12, T16, y1, y2, y3, y4, y5 );
FVS D2(T5,T9,T13,T17,T21, y6, y7, y8, y9, y10 );
FVS D3(T10,T14,T18,T22, 8'd0, y11,y12,y13,y14,y15 );

//Final median value
CS median(y5,y8, y11, High, Mid, Low );

endmodule



//////// TB

module filter5_tb();
reg [7:0] P1, P2, P3, P4, P5, P6, P7, P8, P9,P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23, P24, P25 ;
wire [7:0] Mid;

filter5 dut(.P1(P1), .P2(P2), .P3(P3), .P4(P4), .P5(P5), .P6(P6), .P7(P7), .P8(P8), .P9(P9), .P10(P10), .P11(P11), .P12(P12), .P13(P13), .P14(P14), .P15(P15), .P16(P16), .P17(P17), .P18(P18), .P19(P19), .P20(P20), .P21(P21), .P22(P22), .P23(P23), .P24(P24), .P25(P25), .Mid(Mid));

initial 
begin
#5 P1= 8'd6; P2= 8'd48; P3= 8'd25; P4= 8'd37; P5=8'd40; P6= 8'd43; P7= 8'd33; P8= 8'd7; P9= 8'd21; P10=8'd22 ; P11=8'd28; P12=8'd49 ; P13=8'd35; P14=8'd8; P15=8'd17; P16=8'd32; P17=8'd14; P18=8'd15; P19=8'd16; P20=8'd5; P21=8'd1; P22=8'd41; P23=8'd38; P24=8'd9; P25=8'd26;
#10;
$display(" %d Mid value", Mid);
#5 $finish;
end
endmodule



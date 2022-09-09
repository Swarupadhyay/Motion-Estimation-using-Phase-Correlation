`timescale 1ns / 1ps


module main_cordic_fft(xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8,xin9,xin10,xin11,xin12,xin13,xin14,xin15,xin16,xin17,xin18,xin19,xin20,xin21,xin22,xin23,xin24,xin25,xin26,xin27,xin28,xin29,xin30,xin31,xin32,
								yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8,yin9,yin10,yin11,yin12,yin13,yin14,yin15,yin16,yin17,yin18,yin19,yin20,yin21,yin22,yin23,yin24,yin25,yin26,yin27,yin28,yin29,yin30,yin31,yin32,xout,yout,clock);

  // 32 point 1D FFT
  // 32 complex inputs taken below, x ---> Real part, y ---> Imaginary part
  input signed [15:0] xin1;
  input signed [15:0] xin2;
  input signed [15:0] xin3;
  input signed [15:0] xin4;
  input signed [15:0] xin5;
  input signed [15:0] xin6;
  input signed [15:0] xin7;
  input signed [15:0] xin8;
  input signed [15:0] xin9;
  input signed [15:0] xin10;
  input signed [15:0] xin11;
  input signed [15:0] xin12;
  input signed [15:0] xin13;
  input signed [15:0] xin14;
  input signed [15:0] xin15;
  input signed [15:0] xin16;
  input signed [15:0] xin17;
  input signed [15:0] xin18;
  input signed [15:0] xin19;
  input signed [15:0] xin20;
  input signed [15:0] xin21;
  input signed [15:0] xin22;
  input signed [15:0] xin23;
  input signed [15:0] xin24;
  input signed [15:0] xin25;
  input signed [15:0] xin26;
  input signed [15:0] xin27;
  input signed [15:0] xin28;
  input signed [15:0] xin29;
  input signed [15:0] xin30;
  input signed [15:0] xin31;
  input signed [15:0] xin32;
	
  input signed [15:0] yin1;
  input signed [15:0] yin2;
  input signed [15:0] yin3;
  input signed [15:0] yin4;
  input signed [15:0] yin5;
  input signed [15:0] yin6;
  input signed [15:0] yin7;
  input signed [15:0] yin8;
  input signed [15:0] yin9;
  input signed [15:0] yin10;
  input signed [15:0] yin11;
  input signed [15:0] yin12;
  input signed [15:0] yin13;
  input signed [15:0] yin14;
  input signed [15:0] yin15;
  input signed [15:0] yin16;
  input signed [15:0] yin17;
  input signed [15:0] yin18;
  input signed [15:0] yin19;
  input signed [15:0] yin20;
  input signed [15:0] yin21;
  input signed [15:0] yin22;
  input signed [15:0] yin23;
  input signed [15:0] yin24;
  input signed [15:0] yin25;
  input signed [15:0] yin26;
  input signed [15:0] yin27;
  input signed [15:0] yin28;
  input signed [15:0] yin29;
  input signed [15:0] yin30;
  input signed [15:0] yin31;
  input signed [15:0] yin32;
	
// Ouput(16 bits)corresponding to each input (32 inputs) combined 
// 32 inputs * 16 bits = 512 bits
  output signed [511:0] xout;
  output signed [511:0] yout;

input clock;

genvar i;

  wire signed [31:0] angle_lut [0:15];
  
  // negative angles required for the twiddle factors in forward FFT
  // angles stored as 32 bit binary numbers in the following look up table
  
  assign angle_lut[0] = 'b00000000000000000000000000000000; //0 degree
  assign angle_lut[1] = 'b11111000000000000000000000000000; // -11.25
  assign angle_lut[2] = 'b11110000000000000000000000000000; // -22.5
  assign angle_lut[3] = 'b11101000000000000000000000000000; // -33.75 
  assign angle_lut[4] = 'b11100000000000000000000000000000;
  assign angle_lut[5] = 'b11011000000000000000000000000000;
  assign angle_lut[6] = 'b11010000000000000000000000000000;
  assign angle_lut[7] = 'b11001000000000000000000000000000;
  assign angle_lut[8] = 'b11000000000000000000000000000000;
  assign angle_lut[9] = 'b10111000000000000000000000000000;
  assign angle_lut[10] = 'b10110000000000000000000000000000;
  assign angle_lut[11] = 'b10101000000000000000000000000000;
  assign angle_lut[12] = 'b10100000000000000000000000000000;
  assign angle_lut[13] = 'b10011000000000000000000000000000;
  assign angle_lut[14] = 'b10010000000000000000000000000000;
  assign angle_lut[15] = 'b10001000000000000000000000000000;
  
  
  
  //11.25 - 00001000000000000000000000000000----11111000000000000000000000000000
  // 22.5 - 00010000000000000000000000000000----11110000000000000000000000000000
  // x3 - 00011000000000000000000000000000----11101000000000000000000000000000
  //x4 - 00100000000000000000000000000000----11100000000000000000000000000000**
  // x5 - 00101000000000000000000000000000----11011000000000000000000000000000
  // x6 - 00110000000000000000000000000000----11010000000000000000000000000000
  // x7 - 00111000000000000000000000000000----11001000000000000000000000000000
  // x8 - 01000000000000000000000000000000----11000000000000000000000000000000
  // x9 - 01001000000000000000000000000000----10111000000000000000000000000000
  // x10 - 01010000000000000000000000000000----10110000000000000000000000000000
  // x11 - 01011000000000000000000000000000----10101000000000000000000000000000
  // x12 - 01100000000000000000000000000000----10100000000000000000000000000000
  // x13 - 01101000000000000000000000000000----10011000000000000000000000000000
  // x14 - 01110000000000000000000000000000----10010000000000000000000000000000
  // x15 - 01111000000000000000000000000000----10001000000000000000000000000000
  
	
// Inputs temporary storage arrays
  wire signed[15:0] xtemp_in[0:31];
  wire signed[15:0] ytemp_in[0:31];

// Outputs of the final layer (Layer 5) temporary storage arrays
  wire signed[15:0] xtemp_out[0:31];
  wire signed[15:0] ytemp_out[0:31];

// All the inputs stored in arrays for easy access while using FOR loops
assign {xtemp_in[0],xtemp_in[1],xtemp_in[2],xtemp_in[3],xtemp_in[4],xtemp_in[5],xtemp_in[6],xtemp_in[7],xtemp_in[8],xtemp_in[9],xtemp_in[10],xtemp_in[11],xtemp_in[12],xtemp_in[13],xtemp_in[14],xtemp_in[15],xtemp_in[16],xtemp_in[17],xtemp_in[18],xtemp_in[19],xtemp_in[20],xtemp_in[21],xtemp_in[22],xtemp_in[23],xtemp_in[24],xtemp_in[25],xtemp_in[26],xtemp_in[27],xtemp_in[28],xtemp_in[29],xtemp_in[30],xtemp_in[31]} = {xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8,xin9,xin10,xin11,xin12,xin13,xin14,xin15,xin16,xin17,xin18,xin19,xin20,xin21,xin22,xin23,xin24,xin25,xin26,xin27,xin28,xin29,xin30,xin31,xin32};
assign {ytemp_in[0],ytemp_in[1],ytemp_in[2],ytemp_in[3],ytemp_in[4],ytemp_in[5],ytemp_in[6],ytemp_in[7],ytemp_in[8],ytemp_in[9],ytemp_in[10],ytemp_in[11],ytemp_in[12],ytemp_in[13],ytemp_in[14],ytemp_in[15],ytemp_in[16],ytemp_in[17],ytemp_in[18],ytemp_in[19],ytemp_in[20],ytemp_in[21],ytemp_in[22],ytemp_in[23],ytemp_in[24],ytemp_in[25],ytemp_in[26],ytemp_in[27],ytemp_in[28],ytemp_in[29],ytemp_in[30],ytemp_in[31]} = {yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8,yin9,yin10,yin11,yin12,yin13,yin14,yin15,yin16,yin17,yin18,yin19,yin20,yin21,yin22,yin23,yin24,yin25,yin26,yin27,yin28,yin29,yin30,yin31,yin32};

// Layer 1 temporary storage arrays
  wire signed[15:0] xtemp1[0:31];
  wire signed[15:0] ytemp1[0:31];
  
// Layer 2 temporary storage arrays
  wire signed[15:0] xtemp2[0:31];
  wire signed[15:0] ytemp2[0:31];

// Layer 3 temporary storage arrays
  wire signed[15:0] xtemp3[0:31];
  wire signed[15:0] ytemp3[0:31];
  
// Layer 4 temporary storage arrays
  wire signed[15:0] xtemp4[0:31];
  wire signed[15:0] ytemp4[0:31];


//Layer 1
generate
  for (i=0;i<16;i=i+1)
begin: butterflies1
  butterfly b1(.clock(clock),.x1(xtemp_in[i]),.y1(ytemp_in[i]),.x2(xtemp_in[i+16]),.y2(ytemp_in[i+16]),.zangle(angle_lut[i]),.xout1(xtemp1[i]),.yout1(ytemp1[i]),.xout2(xtemp1[i+16]),.yout2(ytemp1[i+16]));
end
endgenerate


//Layer 2
generate
  for (i=0;i<8;i=i+1)
begin: butterflies2
  butterfly b2(.clock(clock),.x1(xtemp1[i]),.y1(ytemp1[i]),.x2(xtemp1[i+8]),.y2(ytemp1[i+8]),.zangle(angle_lut[2*i]),.xout1(xtemp2[i]),.yout1(ytemp2[i]),.xout2(xtemp2[i+8]),.yout2(ytemp2[i+8]));
  butterfly b3(.clock(clock),.x1(xtemp1[i+16]),.y1(ytemp1[i+16]),.x2(xtemp1[i+24]),.y2(ytemp1[i+24]),.zangle(angle_lut[2*i]),.xout1(xtemp2[i+16]),.yout1(ytemp2[i+16]),.xout2(xtemp2[i+24]),.yout2(ytemp2[i+24]));
end
endgenerate


//Layer 3
generate
  for (i=0;i<4;i=i+1)
begin: butterflies3
  butterfly b4(.clock(clock),.x1(xtemp2[i]),.y1(ytemp2[i]),.x2(xtemp2[i+4]),.y2(ytemp2[i+4]),.zangle(angle_lut[4*i]),.xout1(xtemp3[i]),.yout1(ytemp3[i]),.xout2(xtemp3[i+4]),.yout2(ytemp3[i+4]));
  butterfly b5(.clock(clock),.x1(xtemp2[i+8]),.y1(ytemp2[i+8]),.x2(xtemp2[i+12]),.y2(ytemp2[i+12]),.zangle(angle_lut[4*i]),.xout1(xtemp3[i+8]),.yout1(ytemp3[i+8]),.xout2(xtemp3[i+12]),.yout2(ytemp3[i+12]));
  butterfly b6(.clock(clock),.x1(xtemp2[i+16]),.y1(ytemp2[i+16]),.x2(xtemp2[i+20]),.y2(ytemp2[i+20]),.zangle(angle_lut[4*i]),.xout1(xtemp3[i+16]),.yout1(ytemp3[i+16]),.xout2(xtemp3[i+20]),.yout2(ytemp3[i+20]));
  butterfly b7(.clock(clock),.x1(xtemp2[i+24]),.y1(ytemp2[i+24]),.x2(xtemp2[i+28]),.y2(ytemp2[i+28]),.zangle(angle_lut[4*i]),.xout1(xtemp3[i+24]),.yout1(ytemp3[i+24]),.xout2(xtemp3[i+28]),.yout2(ytemp3[i+28]));
end
endgenerate
  
  
//Layer 4   
generate
for (i=0;i<2;i=i+1)
begin: butterflies4
  butterfly b8(.clock(clock),.x1(xtemp3[i]),.y1(ytemp3[i]),.x2(xtemp3[i+2]),.y2(ytemp3[i+2]),.zangle(angle_lut[8*i]),.xout1(xtemp4[i]),.yout1(ytemp4[i]),.xout2(xtemp4[i+2]),.yout2(ytemp4[i+2]));
  butterfly b9(.clock(clock),.x1(xtemp3[i+4]),.y1(ytemp3[i+4]),.x2(xtemp3[i+6]),.y2(ytemp3[i+6]),.zangle(angle_lut[8*i]),.xout1(xtemp4[i+4]),.yout1(ytemp4[i+4]),.xout2(xtemp4[i+6]),.yout2(ytemp4[i+6]));
  butterfly b10(.clock(clock),.x1(xtemp3[i+8]),.y1(ytemp3[i+8]),.x2(xtemp3[i+10]),.y2(ytemp3[i+10]),.zangle(angle_lut[8*i]),.xout1(xtemp4[i+8]),.yout1(ytemp4[i+8]),.xout2(xtemp4[i+10]),.yout2(ytemp4[i+10]));
  butterfly b11(.clock(clock),.x1(xtemp3[i+12]),.y1(ytemp3[i+12]),.x2(xtemp3[i+14]),.y2(ytemp3[i+14]),.zangle(angle_lut[8*i]),.xout1(xtemp4[i+12]),.yout1(ytemp4[i+12]),.xout2(xtemp4[i+14]),.yout2(ytemp4[i+14]));
  butterfly b12(.clock(clock),.x1(xtemp3[i+16]),.y1(ytemp3[i+16]),.x2(xtemp3[i+18]),.y2(ytemp3[i+18]),.zangle(angle_lut[8*i]),.xout1(xtemp4[i+16]),.yout1(ytemp4[i+16]),.xout2(xtemp4[i+18]),.yout2(ytemp4[i+18]));
  butterfly b13(.clock(clock),.x1(xtemp3[i+20]),.y1(ytemp3[i+20]),.x2(xtemp3[i+22]),.y2(ytemp3[i+22]),.zangle(angle_lut[8*i]),.xout1(xtemp4[i+20]),.yout1(ytemp4[i+20]),.xout2(xtemp4[i+22]),.yout2(ytemp4[i+22]));
  butterfly b14(.clock(clock),.x1(xtemp3[i+24]),.y1(ytemp3[i+24]),.x2(xtemp3[i+26]),.y2(ytemp3[i+26]),.zangle(angle_lut[8*i]),.xout1(xtemp4[i+24]),.yout1(ytemp4[i+24]),.xout2(xtemp4[i+26]),.yout2(ytemp4[i+26]));
  butterfly b15(.clock(clock),.x1(xtemp3[i+28]),.y1(ytemp3[i+28]),.x2(xtemp3[i+30]),.y2(ytemp3[i+30]),.zangle(angle_lut[8*i]),.xout1(xtemp4[i+28]),.yout1(ytemp4[i+28]),.xout2(xtemp4[i+30]),.yout2(ytemp4[i+30]));
 
end
endgenerate  

// Layer 5
//bit reversal of outputs is taken into consideration  
  butterfly b16(.clock(clock),.x1(xtemp4[0]),.y1(ytemp4[0]),.x2(xtemp4[1]),.y2(ytemp4[1]),.zangle(angle_lut[0]),.xout1(xtemp_out[0]),.yout1(ytemp_out[0]),.xout2(xtemp_out[16]),.yout2(ytemp_out[16]));
  butterfly b17(.clock(clock),.x1(xtemp4[2]),.y1(ytemp4[2]),.x2(xtemp4[3]),.y2(ytemp4[3]),.zangle(angle_lut[0]),.xout1(xtemp_out[8]),.yout1(ytemp_out[8]),.xout2(xtemp_out[24]),.yout2(ytemp_out[24]));
  butterfly b18(.clock(clock),.x1(xtemp4[4]),.y1(ytemp4[4]),.x2(xtemp4[5]),.y2(ytemp4[5]),.zangle(angle_lut[0]),.xout1(xtemp_out[4]),.yout1(ytemp_out[4]),.xout2(xtemp_out[20]),.yout2(ytemp_out[20]));
  butterfly b19(.clock(clock),.x1(xtemp4[6]),.y1(ytemp4[6]),.x2(xtemp4[7]),.y2(ytemp4[7]),.zangle(angle_lut[0]),.xout1(xtemp_out[12]),.yout1(ytemp_out[12]),.xout2(xtemp_out[28]),.yout2(ytemp_out[28]));

  butterfly b20(.clock(clock),.x1(xtemp4[8]),.y1(ytemp4[8]),.x2(xtemp4[9]),.y2(ytemp4[9]),.zangle(angle_lut[0]),.xout1(xtemp_out[2]),.yout1(ytemp_out[2]),.xout2(xtemp_out[18]),.yout2(ytemp_out[18]));
  butterfly b21(.clock(clock),.x1(xtemp4[10]),.y1(ytemp4[10]),.x2(xtemp4[11]),.y2(ytemp4[11]),.zangle(angle_lut[0]),.xout1(xtemp_out[10]),.yout1(ytemp_out[10]),.xout2(xtemp_out[26]),.yout2(ytemp_out[26]));
  butterfly b22(.clock(clock),.x1(xtemp4[12]),.y1(ytemp4[12]),.x2(xtemp4[13]),.y2(ytemp4[13]),.zangle(angle_lut[0]),.xout1(xtemp_out[6]),.yout1(ytemp_out[6]),.xout2(xtemp_out[22]),.yout2(ytemp_out[22]));
  butterfly b23(.clock(clock),.x1(xtemp4[14]),.y1(ytemp4[14]),.x2(xtemp4[15]),.y2(ytemp4[15]),.zangle(angle_lut[0]),.xout1(xtemp_out[14]),.yout1(ytemp_out[14]),.xout2(xtemp_out[30]),.yout2(ytemp_out[30]));
  
  butterfly b24(.clock(clock),.x1(xtemp4[16]),.y1(ytemp4[16]),.x2(xtemp4[17]),.y2(ytemp4[17]),.zangle(angle_lut[0]),.xout1(xtemp_out[1]),.yout1(ytemp_out[1]),.xout2(xtemp_out[17]),.yout2(ytemp_out[17]));
  butterfly b25(.clock(clock),.x1(xtemp4[18]),.y1(ytemp4[18]),.x2(xtemp4[19]),.y2(ytemp4[19]),.zangle(angle_lut[0]),.xout1(xtemp_out[9]),.yout1(ytemp_out[9]),.xout2(xtemp_out[25]),.yout2(ytemp_out[25]));
  butterfly b26(.clock(clock),.x1(xtemp4[20]),.y1(ytemp4[20]),.x2(xtemp4[21]),.y2(ytemp4[21]),.zangle(angle_lut[0]),.xout1(xtemp_out[5]),.yout1(ytemp_out[5]),.xout2(xtemp_out[21]),.yout2(ytemp_out[21]));
  butterfly b27(.clock(clock),.x1(xtemp4[22]),.y1(ytemp4[22]),.x2(xtemp4[23]),.y2(ytemp4[23]),.zangle(angle_lut[0]),.xout1(xtemp_out[13]),.yout1(ytemp_out[13]),.xout2(xtemp_out[29]),.yout2(ytemp_out[29]));

  butterfly b28(.clock(clock),.x1(xtemp4[24]),.y1(ytemp4[24]),.x2(xtemp4[25]),.y2(ytemp4[26]),.zangle(angle_lut[0]),.xout1(xtemp_out[3]),.yout1(ytemp_out[3]),.xout2(xtemp_out[19]),.yout2(ytemp_out[19]));
  butterfly b29(.clock(clock),.x1(xtemp4[26]),.y1(ytemp4[26]),.x2(xtemp4[27]),.y2(ytemp4[27]),.zangle(angle_lut[0]),.xout1(xtemp_out[11]),.yout1(ytemp_out[11]),.xout2(xtemp_out[27]),.yout2(ytemp_out[27]));
  butterfly b30(.clock(clock),.x1(xtemp4[28]),.y1(ytemp4[28]),.x2(xtemp4[29]),.y2(ytemp4[29]),.zangle(angle_lut[0]),.xout1(xtemp_out[7]),.yout1(ytemp_out[7]),.xout2(xtemp_out[23]),.yout2(ytemp_out[23]));
  butterfly b31(.clock(clock),.x1(xtemp4[30]),.y1(ytemp4[30]),.x2(xtemp4[31]),.y2(ytemp4[31]),.zangle(angle_lut[0]),.xout1(xtemp_out[15]),.yout1(ytemp_out[15]),.xout2(xtemp_out[31]),.yout2(ytemp_out[31]));


  // Outputs stores in temporary arrays concatenated to a single 512 bit output
  assign xout = {xtemp_out[0],xtemp_out[1],xtemp_out[2],xtemp_out[3],xtemp_out[4],xtemp_out[5],xtemp_out[6],xtemp_out[7],xtemp_out[8],xtemp_out[9],xtemp_out[10],xtemp_out[11],xtemp_out[12],xtemp_out[13],xtemp_out[14],xtemp_out[15],xtemp_out[16],xtemp_out[17],xtemp_out[18],xtemp_out[19],xtemp_out[20],xtemp_out[21],xtemp_out[22],xtemp_out[23],xtemp_out[24],xtemp_out[25],xtemp_out[26],xtemp_out[27],xtemp_out[28],xtemp_out[29],xtemp_out[30],xtemp_out[31]};
  assign yout = {ytemp_out[0],ytemp_out[1],ytemp_out[2],ytemp_out[3],ytemp_out[4],ytemp_out[5],ytemp_out[6],ytemp_out[7],ytemp_out[8],ytemp_out[9],ytemp_out[10],ytemp_out[11],ytemp_out[12],ytemp_out[13],ytemp_out[14],ytemp_out[15],ytemp_out[16],ytemp_out[17],ytemp_out[18],ytemp_out[19],ytemp_out[20],ytemp_out[21],ytemp_out[22],ytemp_out[23],ytemp_out[24],ytemp_out[25],ytemp_out[26],ytemp_out[27],ytemp_out[28],ytemp_out[29],ytemp_out[30],ytemp_out[31]};

    
endmodule



// BUTTERFLY MODULE
// TWO INPUTS AT A TIME
// DIF FFT ALGORITHM USED
// TWO OUTPUTS CORRESPONDING TO EACH INPUT  

module butterfly(
	input clock,
	input signed [15:0] x1,
	input signed [15:0] y1,
	input signed [15:0] x2,
	input signed [15:0] y2,
	input signed [31:0] zangle,
	output signed [15:0] xout1,
	output signed [15:0] yout1,
	output signed [15:0] xout2,
	output signed [15:0] yout2
   );

// Temporary variabbles to store output 
wire signed [15:0] xtemp3,ytemp3;  

// FISRT OUTPUT ---> DIRECT SUM OF THE INPUTS
  assign xout1 = (x1 +x2);
  assign yout1 = (y1 +y2);  

// SECOND OUTPUT ---> ROTATION OF THE DIFFERENCE OF THE INPUTS BY A GIVEN ANGLE 
// CORDIC MODULE USED
  cordic c3(clock,x1-x2,y1 - y2,zangle,xtemp3,ytemp3, done);

// Assigning the value of the temporary variables to the second output
assign xout2 = xtemp3;
assign yout2 = ytemp3;  

endmodule


// CORDIC MODULE

module cordic(
    input clock,
    input signed [15:0] xstart,
    input signed [15:0] ystart,
    input signed [31:0] zangle,
    output signed [15:0] xout,
    output signed [15:0] yout,
    output reg done
    );

reg znext;

wire signed [31:0] atan_table[0:15];


assign atan_table[00] = 'b00100000000000000000000000000000; // 45.000 degrees -> atan(2^0)
assign atan_table[01] = 'b00010010111001000000010100011101; // 26.565 degrees -> atan(2^-1)
assign atan_table[02] = 'b00001001111110110011100001011011; // 14.036 degrees -> atan(2^-2)
assign atan_table[03] = 'b00000101000100010001000111010100; // atan(2^-3)
assign atan_table[04] = 'b00000010100010110000110101000011;
assign atan_table[05] = 'b00000001010001011101011111100001;
assign atan_table[06] = 'b00000000101000101111011000011110;
assign atan_table[07] = 'b00000000010100010111110001010101;
assign atan_table[08] = 'b00000000001010001011111001010011;
assign atan_table[09] = 'b00000000000101000101111100101110;
assign atan_table[10] = 'b00000000000010100010111110011000;
assign atan_table[11] = 'b00000000000001010001011111001100;
assign atan_table[12] = 'b00000000000000101000101111100110;
assign atan_table[13] = 'b00000000000000010100010111110011;
assign atan_table[14] = 'b00000000000000001010001011111001;
assign atan_table[15] = 'b00000000000000000101000101111100;

parameter width = 16;

reg signed [15:0] xcomp_start,ycomp_start;
reg [3:0] out = 4'b0000;


wire [1:0] quad;
assign quad = zangle[31:30];

reg signed [width:0] x [0:width-1];
reg signed [width:0] y [0:width-1];
reg signed [31:0] z [0:width-1]; // col z[rows]


always @(posedge clock)
begin

xcomp_start = (xstart>>>1)+(xstart>>>4)+(xstart>>>5);
ycomp_start = (ystart>>>1)+(ystart>>>4)+(ystart>>>5);

// if no scaling done
//xcomp_start = (xstart);
//ycomp_start = (ystart);

case(quad)
	2'b00,2'b11:
		begin		// -90 to 90
		x[0] <= xcomp_start;
		y[0] <= ycomp_start;
		z[0] <= zangle;
		end
	2'b01:				//subtract 90	(second quadrant)
		begin
		x[0] <= -ycomp_start;
		y[0] <= xcomp_start;
		z[0] <= {2'b00,zangle[29:0]};
		end
	2'b10:				// add 90 (third quadrant)
		begin
		x[0] <= ycomp_start;			
		y[0] <= -xcomp_start;
		z[0] <= {2'b11,zangle[29:0]};
		end
		
endcase
end


genvar i;
generate
for (i=0;i<15;i=i+1)
begin: iterations

	wire signed [width:0] xshift, yshift;

	assign xshift = x[i] >>> i; // signed shift right
	assign yshift = y[i] >>> i;

	always @(posedge clock)
		begin
		x[i+1] <= z[i][31] ? x[i]+ yshift:x[i]-yshift;
		y[i+1] <= z[i][31] ? y[i]-xshift:y[i]+xshift;
		z[i+1] <= z[i][31] ? z[i]+atan_table[i]:z[i]-atan_table[i];
        out <= out+1;
        if (out == 4'b1111)
        done = 'b1;
        else
        done = 'b0;

	end


end
endgenerate


assign xout = x[width-1];
assign yout = y[width-1];

endmodule
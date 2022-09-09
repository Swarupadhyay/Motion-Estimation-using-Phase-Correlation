`timescale 1ns / 1ps
//COordinate Rotation Digital Computer
//Hardware method to calculate sine and cosine of an angle using rotation principle

module CORDIC_main(clock, cosine, sine, x_start, y_start, angle);
  // no. of iterations
  parameter width = 16;

  // Inputs
  input clock;
  input signed [width-1:0] x_start,y_start; 
  input signed [31:0] angle;
  // Input coordinates as well as angle are signed(can take +ve/-ve values)

  // Outputs
  output signed  [width-1:0] sine, cosine;

  // Generate table of atan values
  // Array of arctan values are defined below
  // The index of atan_table represents the iteration no.
  // The tan angles are chosen such that the tangent of these angles are in powers of 1/2
  // 1/2 is chosen because multiplication of a binary no. by a power of 1/2 is equivalent to right-shifting the 32-bit binary no. 
  wire signed [31:0] atan_table [0:30];
                          
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
  assign atan_table[16] = 'b00000000000000000010100010111110;
  assign atan_table[17] = 'b00000000000000000001010001011111;
  assign atan_table[18] = 'b00000000000000000000101000101111;
  assign atan_table[19] = 'b00000000000000000000010100010111;
  assign atan_table[20] = 'b00000000000000000000001010001011;
  assign atan_table[21] = 'b00000000000000000000000101000101;
  assign atan_table[22] = 'b00000000000000000000000010100010;
  assign atan_table[23] = 'b00000000000000000000000001010001;
  assign atan_table[24] = 'b00000000000000000000000000101000;
  assign atan_table[25] = 'b00000000000000000000000000010100;
  assign atan_table[26] = 'b00000000000000000000000000001010;
  assign atan_table[27] = 'b00000000000000000000000000000101;
  assign atan_table[28] = 'b00000000000000000000000000000010;
  assign atan_table[29] = 'b00000000000000000000000000000001;
  assign atan_table[30] = 'b00000000000000000000000000000000;

  // define arrays that store the values of the x,y coordinates at the end of each iteration
  // define arrays that store the values of the angle z at the end of each iteration
  reg signed [width:0] x [0:width-1];
  reg signed [width:0] y [0:width-1];
  reg signed    [31:0] z [0:width-1];
  
  reg signed [15:0] xcomp_start,ycomp_start;


  // make sure given angle is in -pi/2 to pi/2 range(I, IV quadrant)
  // This is because the arctan table is chosen such that it includes angles equal to and less than 45 degrees
  wire [1:0] quadrant;
  assign quadrant = angle[31:30]; // First two bits of the angle determines the quadrant

  always @(posedge clock) begin
     // the following shift is done to divide the value by CORDIC GAIN
     // here, CORDIC gain is equal to 0.607, which is roughly attained by adding the resultant of right shifthing the value by 1, 4 and 5
     xcomp_start = (x_start>>>1)+(x_start>>>4)+(x_start>>>5);
     ycomp_start = (y_start>>>1)+(y_start>>>4)+(y_start>>>5);
  
    // make sure the rotation angle is in the -pi/2 to pi/2 range
    case(quadrant)
      2'b00,
      2'b11: // no changes needed for these quadrants
      begin
        x[0] <= xcomp_start;
        y[0] <= ycomp_start;
        z[0] <= angle;
      end
      
      2'b01:
      begin
      // subtraction of pi/2 into the angle changes the {sin, cos} value to {-cos, sin}
      // therefore the coordinates are interchanged accordingly
        x[0] <= -ycomp_start;
        y[0] <= xcomp_start;
        z[0] <= {2'b00,angle[29:0]}; // subtract pi/2 for angle in this quadrant
      end

      // addition of pi/2 into the angle changes the {sin, cos} value to {cos, -sin}
      // therefore the coordinates are interchanged accordingly
      2'b10:
      begin
        x[0] <= ycomp_start;
        y[0] <= -xcomp_start;
        z[0] <= {2'b11,angle[29:0]}; // add pi/2 to angles in this quadrant
      end
    endcase
  end


  // run through iterations
  // use generate as we are using both, continuous as well as procedural assignments
  genvar i;

  generate
  for (i=0; i < (width-1); i=i+1)
  begin: xyz
    wire z_sign;
    wire signed [width:0] x_shr, y_shr;

    // '>>>'/'<<<' is used to shift 'signed' bits
    assign x_shr = x[i] >>> i; // signed shift right
    assign y_shr = y[i] >>> i; // signed shift right

    //the sign of the current rotation angle
    // the signed bit would be the most significant bit of the angle
    assign z_sign = z[i][31];

    always @(posedge clock)
    begin
    // 1/2 is chosen because multiplication of a binary no. by a power of 1/2 is equivalent to right-shifting the 32-bit binary no. 
      // add/subtract shifted data
      // the following equations are derived from the matrix equation corresponding to the rotation operation
      // direction of the angle determines the opertation to be implemented on the current coordinates
      
    //The actual process involves multiplication in terms of shifting with tangent of the angles whose arc tan values are in the power of 1/2
      x[i+1] <= z_sign ? x[i] + y_shr : x[i] - y_shr;
      y[i+1] <= z_sign ? y[i] - x_shr : y[i] + x_shr;
      // if after a particular iteration we find the angle to be in the IV quadrant, 
      // then our algorithm should assign a rotation in the anti-clockwise direction in 
      // the next iteration considering that the given angle is in the I quadrant
      z[i+1] <= z_sign ? z[i] + atan_table[i] : z[i] - atan_table[i];
    end
  end
  endgenerate

  // assign output
  // the given coordinates corresponds to the rotated angle after 'width' iterations
  assign cosine = x[width-1];
  assign sine = y[width-1];

endmodule
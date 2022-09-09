`timescale 1ns / 1ps

module main_tb;

	// Inputs
  reg [15:0] xin1;
  reg [15:0] xin2;
  reg [15:0] xin3;
  reg [15:0] xin4;
  reg [15:0] xin5;
  reg [15:0] xin6;
  reg [15:0] xin7;
  reg [15:0] xin8;
  reg [15:0] xin9;
  reg [15:0] xin10;
  reg [15:0] xin11;
  reg [15:0] xin12;
  reg [15:0] xin13;
  reg [15:0] xin14;
  reg [15:0] xin15;
  reg [15:0] xin16;
  reg [15:0] xin17;
  reg [15:0] xin18;
  reg [15:0] xin19;
  reg [15:0] xin20;
  reg [15:0] xin21;
  reg [15:0] xin22;
  reg [15:0] xin23;
  reg [15:0] xin24;
  reg [15:0] xin25;
  reg [15:0] xin26;
  reg [15:0] xin27;
  reg [15:0] xin28;
  reg [15:0] xin29;
  reg [15:0] xin30;
  reg [15:0] xin31;
  reg [15:0] xin32;
  reg [15:0] yin1;
  reg [15:0] yin2;
  reg [15:0] yin3;
  reg [15:0] yin4;
  reg [15:0] yin5;
  reg [15:0] yin6;
  reg [15:0] yin7;
  reg [15:0] yin8;
  reg [15:0] yin9;
  reg [15:0] yin10;
  reg [15:0] yin11;
  reg [15:0] yin12;
  reg [15:0] yin13;
  reg [15:0] yin14;
  reg [15:0] yin15;
  reg [15:0] yin16;
  reg [15:0] yin17;
  reg [15:0] yin18;
  reg [15:0] yin19;
  reg [15:0] yin20;
  reg [15:0] yin21;
  reg [15:0] yin22;
  reg [15:0] yin23;
  reg [15:0] yin24;
  reg [15:0] yin25;
  reg [15:0] yin26;
  reg [15:0] yin27;
  reg [15:0] yin28;
  reg [15:0] yin29;
  reg [15:0] yin30;
  reg [15:0] yin31;
  reg [15:0] yin32;
	reg clock;
  parameter An = 1;

	// Outputs
  wire [511:0] xout;
  wire [511:0] yout;

	// Instantiate the Unit Under Test (UUT)
	main_cordic_fft uut (
		.xin1(xin1), 
		.xin2(xin2), 
		.xin3(xin3), 
		.xin4(xin4), 
		.xin5(xin5), 
		.xin6(xin6), 
		.xin7(xin7), 
		.xin8(xin8), 
		.xin9(xin9), 
		.xin10(xin10), 
		.xin11(xin11), 
		.xin12(xin12), 
		.xin13(xin13), 
		.xin14(xin14), 
		.xin15(xin15), 
		.xin16(xin16), 
      .xin17(xin17), 
      .xin18(xin18), 
      .xin19(xin19), 
      .xin20(xin20), 
      .xin21(xin21), 
      .xin22(xin22), 
      .xin23(xin23), 
      .xin24(xin24), 
      .xin25(xin25), 
      .xin26(xin26), 
      .xin27(xin27), 
      .xin28(xin28), 
      .xin29(xin29), 
      .xin30(xin30), 
      .xin31(xin31), 
      .xin32(xin32), 
		.yin1(yin1), 
		.yin2(yin2), 
		.yin3(yin3), 
		.yin4(yin4), 
		.yin5(yin5), 
		.yin6(yin6), 
		.yin7(yin7), 
		.yin8(yin8), 
		.yin9(yin9), 
		.yin10(yin10), 
		.yin11(yin11), 
		.yin12(yin12), 
		.yin13(yin13), 
		.yin14(yin14), 
		.yin15(yin15), 
		.yin16(yin16), 
      .yin17(yin17), 
      .yin18(yin18), 
      .yin19(yin19), 
      .yin20(yin20), 
      .yin21(yin21), 
      .yin22(yin22), 
      .yin23(yin23), 
      .yin24(yin24), 
      .yin25(yin25), 
      .yin26(yin26), 
      .yin27(yin27), 
      .yin28(yin28), 
      .yin29(yin29), 
      .yin30(yin30), 
      .yin31(yin31), 
      .yin32(yin32), 
		.xout(xout), 
		.yout(yout), 
		.clock(clock)
	);

	initial begin
      
      	//$dumpfile("dump.vcd"); $dumpvars;
      
		// Initialize Inputs
		xin1 = 0;
		xin2 = 0;
		xin3 = 0;
		xin4 = 0;
		xin5 = 0;
		xin6 = 0;
		xin7 = 0;
		xin8 = 0;
		xin9 = 0;
		xin10 = 0;
		xin11 = 0;
		xin12 = 0;
		xin13 = 0;
		xin14 = 0;
		xin15 = 0;
		xin16 = 0;
        xin17 = 0;
		xin18 = 0;
		xin19 = 0;
		xin20 = 0;
		xin21 = 0;
		xin22 = 0;
		xin23 = 0;
		xin24 = 0;
		xin25 = 0;
		xin26 = 0;
		xin27 = 0;
		xin28 = 0;
		xin29 = 0;
		xin30 = 0;
		xin31 = 0;
		xin32 = 0;
		yin1 = 0;
		yin2 = 0;
		yin3 = 0;
		yin4 = 0;
		yin5 = 0;
		yin6 = 0;
		yin7 = 0;
		yin8 = 0;
		yin9 = 0;
		yin10 = 0;
		yin11 = 0;
		yin12 = 0;
		yin13 = 0;
		yin14 = 0;
		yin15 = 0;
		yin16 = 0;
        yin17 = 0;
		yin18 = 0;
		yin19 = 0;
		yin20 = 0;
		yin21 = 0;
		yin22 = 0;
		yin23 = 0;
		yin24 = 0;
		yin25 = 0;
		yin26 = 0;
		yin27 = 0;
		yin28 = 0;
		yin29 = 0;
		yin30 = 0;
		yin31 = 0;
		yin32 = 0;
		clock = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

		xin1=  255*An;
		xin2 = 255*An;
		xin3 = 255*An;
		xin4 = 255*An;
		xin5 = 255*An;
		xin6 = 255*An;
		xin7 = 255*An;
		xin8 = 255*An;
		xin9 = 0;
		xin10 = 0;          
		xin11= 0;
	    xin12 = 0;
	    xin13 = 0;
	    xin14 = 0;
	    xin15 = 0;
	    xin16 = 0;
      
        xin17 = 0;
		xin18 = 0;
		xin19 = 0;
		xin20 = 0;
		xin21 = 0;
		xin22 = 0;
		xin23 = 0;
		xin24 = 0;
		xin25 = 0;
		xin26 = 0;
		xin27 = 0;
		xin28 = 0;
		xin29 = 0;
		xin30 = 0;
		xin31 = 0;
		xin32 = 0;
	    
    		

		//xin2='b0000011111001101;
		//xin3='b0000000110100110;
		//xin4='b0000000110100110;
		//xin5='b0000011111001101;
		//xin6='b0000010000000000;
		//xin7='b0000000000110010;
		//xin8='b0000011001011001;
		//xin9='b0000011001011001;
		//xin10='b0000000000110010;
		//xin11='b0000001111111111;
		//xin12='b0000011111001101;
		//xin13='b0000000110100110;
		//xin14='b0000000110100110;
		//xin15='b0000011111001101;
		//xin16='b0000010000000000;
		
	
		#5000

		$display(" The input is x = %b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n  y=%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n \n",xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8,xin9,xin10,xin11,xin12,xin13,xin14,xin15,xin16,xin17,xin18,xin19,xin20,xin21,xin22,xin23,xin24,xin25,xin26,xin27,xin28,xin29,xin30,xin31,xin32,yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8,yin9,yin10,yin11,yin12,yin13,yin14,yin15,yin16,yin17,yin18,yin19,yin20,yin21,yin22,yin23,yin24,yin25,yin26,yin27,yin28,yin29,yin30,yin31,yin32);
	 
      $display(" The result is %b\n The result is %b \n",xout,yout);
		
	end
	initial begin
		#100
		clock ='b0;
		forever
		begin
			#5
			clock=!clock;
		end
		
	end
  
  
//0000010100000011000000000000000000000100111011110000000000000000000001001110000100000000000000000000010010111111000000000000000000000100111001110000000000000000000001001011011000000000000000000000010010110010000000000000000000000100100101000010001111100010
  //0000001111110101000000000000000000000011111111100000000000000000000000111111100100000000000000000000010000000000000000000000000000000011111110110000000000000000000000111111011100000000000000000000001111110100000000000000000000000011111110010001111111110110
      
endmodule
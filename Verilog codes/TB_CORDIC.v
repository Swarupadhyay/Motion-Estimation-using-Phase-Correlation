//CORDIC Testbench for sine and cosine for Final Project 


module testbench_CORDIC_main;

  parameter width = 16; //width of x and y

  // Inputs
  reg signed [width-1:0] x_start, y_start;
  reg signed [31:0] angle;
  reg clock;
  //reg signed [63:0] i;

  wire signed [width-1:0] cosine, sine;

  parameter An = 32000; 
   // here, 32000 is the scaling factor
   // 32,000 is multiplied, as a random constant, so that verilog can process and display the <1 values efficiently 


  CORDIC_main Instance(clock, cosine, sine, x_start, y_start, angle);

  initial begin
    
    //set clock
    clock = 'b0;
    
    //set initial values
    //angle = 'b00010010111001000000010100011101;
    //90 degrees = 1073741824
    // Input angle = x
    // y = 90/x 
    
    
    // degree angle is represented below in binary format
    angle = 1073741824/1.5; // 60 degrees (angle)
    x_start = An;     // Xout = 32000*cos(angle)
    y_start = 0;      // Yout = 32000*sin(angle)    
    
  end
  always #5 clock = !clock;
  



endmodule
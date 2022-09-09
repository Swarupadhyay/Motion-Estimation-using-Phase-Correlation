`timescale 1ns / 1ps

module TB_FFT2D;
    
    reg clk;
    parameter N = 16384;//32x32x16
    parameter INFILE = "D:/Sem-III/ES 203 Digital Systems/32P1.hex";
    
    wire signed [N-1:0]xout;
    wire signed [N-1:0]yout;
    
    FFT2D Instance(clk,xout,yout);
    
//    initial
//begin
//$readmemb(INFILE, in_ram);
//end
    
    initial begin 
        clk=0;
        
         #1000;
    $display("%16384b'\n%16384b'", xout, yout);
        
    end
    
    always #0.1 clk = ~clk;
    
   

endmodule

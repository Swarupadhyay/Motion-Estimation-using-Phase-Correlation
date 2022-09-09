`timescale 1ns / 1ps
module TB_phase_correlation;

    reg clk;
    parameter N = 16384;//32x32x16
    parameter M = 32768;
    parameter INFILE_img1 = "D:/Sem-III/ES 203 Digital Systems/32P1.hex";
    parameter INFILE_img2 = "D:/Sem-III/ES 203 Digital Systems/32P2.hex";
    
    wire [N-1:0]xout_final;
    wire [N-1:0]yout_final;

    Phase_corr_FFT Instance( clk, xout_final, yout_final);

    
    initial begin 
        clk=0;
        
         #1000;
    $display("%16384b'\n%16384b'", xout_final, yout_final);
        
    end
    
    always #0.1 clk = ~clk;  
   

endmodule

`timescale 1ns / 1ps

module Phase_corr_FFT( clk, xout_final, yout_final);

parameter N = 16384;//32x32x16

input clk;

// No inputs taken here
// The FFT MODULES CALLED BELOW ACCOUNT FOE THE INPUT FRAMES/IMAGE MATRIX
// OUTPUT MATRIX STORED (32*32 elements * 16 bits)
output signed [N-1:0]xout_final, yout_final;


// WIRES TO STORE THE 2D FFT MATRIX OF THE FIRST FRAME
wire signed [N-1:0]x1out;
wire signed [N-1:0]y1out; 

// FIRST FRAME/IMAGE 2D FFT MODULE CALLED
FFT_2D image1(clk,x1out,y1out);  


// WIRES TO STORE THE 2D FFT MATRIX OF THE SECOND FRAME
wire signed [N-1:0]x2out;
wire signed [N-1:0]y2out; 
 
// SECOND FRAME/IMAGE 2D FFT MODULE CALLED
FFT_2D_frame2 image2(clk,x2out,y2out);     


// TEMP WIRES TO STORE THE CPS MATRIX
// (32*32 elements * 16 bits)
wire signed [N-1:0]xf;
wire signed [N-1:0]yf;


// GENERATE BLOCK TO COMPUTE THE CPS MATRIX
// CPS ---> CROSS POWER SPECTRUM
// INVOLVES SIGNED ELEMENST WISE MULTIPLICATION OF THE FIRST 2D FFT MATRIX 
// WITH THE CONJUGATE OF THE SECOND 2D FFT MATRIX CALCULATED ABOVE  
// THE PRODUCT IS THEN NORMAILZED, HERE WE HAVE SUED A CONSTANT FACTOR INSTEAD 
// ON INSPECTING BOTH THE NORMALIZED AND DIVISION WITH CONSTANT FACTOR (10000) ALGORITHM, 
// WE CONCLUDED THAT THE ERROR INCURRED IN THIS ALGORITHM DOESNT CREATE A SIGNIFIACNT IMPACT IN THE fINAL OUTPUT
// THOUGH THE SHARPNESS OF THE PEAK OBTAINED IS COMPROMISED

genvar i;
generate
    for(i = 0; i<N;i = i+16) begin: element_multi
    
    assign xf[i+15:i] = ($signed(x1out[i+15:i])$signed(x2out[i+15:i]))/320000 + ($signed(y1out[i+15:i])$signed(y2out[i+15:i]))/320000;
    assign yf[i+15:i] = (-$signed(x1out[i+15:i])$signed(y2out[i+15:i]))/320000 + ($signed(x2out[i+15:i])$signed(y1out[i+15:i]))/320000;
    
//    assign xout_final[i+15:i] = ($signed(x1out[i+15:i])$signed(x2out[i+15:i]))/320000 + ($signed(y1out[i+15:i])$signed(y2out[i+15:i]))/320000;
//    assign yout_final[i+15:i] = (-$signed(x1out[i+15:i])$signed(y2out[i+15:i]))/320000 + ($signed(x2out[i+15:i])$signed(y1out[i+15:i]))/320000;
    
    end
endgenerate


// 2D INVERSE MODULE CALLED TO CALCULATE THE INVERSE OF THE CPS MATRIX
// FINAL OUPUT MATRIX GENERATED
Inverse_fft invfinal(clk, xf, yf, xout_final, yout_final);


// OUTPUT MATRIX DISPLAYED IN TCL CONSOLE FOR VALIDATION
integer a;
initial begin
            #70;
            for(a=N-1; a>=0 ; a=a-16) begin //32x32 = 1024
                $display("%b\n",xout_final[a-:16]);
            end
            
            //$display("%b",temp_BMP[2]);
            
    end


endmodule

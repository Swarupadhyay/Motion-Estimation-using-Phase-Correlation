`timescale 1ns / 1ps
//2Dimensional Fast fourier Transfrom
module FFT2D(clk,xout,yout);
    //input
    input clk;
    
    //define a parameter N equal to the total no. of bits in the image data
    //N will be equal to no. of pixels in the image times the bit size of a particular pixel
    parameter N = 16384;//32x32x16
    //parametrize the file location of the input image
    parameter INFILE = "D:\Sem-III\ES 203 Digital Systems\Lion1.hex";
    
    //output data
    output signed[N-1:0]xout;//real
    output signed[N-1:0]yout;//imaginary
    
    //define a temp_BMP register that will store the input image data for further processing
    reg signed[15:0]temp_BMP [0 : 1023];

    //integer i;
    //use the inbuilt 'readmemh' function that will read the input umage data from its '.hex' file
    //store it in the temp_BMP reg
    initial begin
        $readmemh(INFILE,temp_BMP,0,1023); // read file from INFILE
    end

    //ROW
    //wires for storing the 1D FFT data when iterated over each row
    wire signed[511:0]temp_xout[0:31]; //512 is the no. of bits in the output of a 1D FFT with input 32inputs each of 16 bits
    wire signed[511:0]temp_yout[0:31];
    
    //we will use generate block to call the 1D FFT module over each row of image matrix data
    genvar j;
    generate
        //increment the j value by 32 each time to proceed to the next row
        //the for loop will iterate till all the row value are processed in the 1-D FFT
        for(j=0; j<1024; j=j+32)begin: row
                 
            main_cordic_fft  row_FFT(temp_BMP[j],
             temp_BMP[j+1], temp_BMP[j+2], temp_BMP[j+3], temp_BMP[j+4], temp_BMP[j+5], temp_BMP[j+6], temp_BMP[j+7], temp_BMP[j+8], temp_BMP[j+9], temp_BMP[j+10], temp_BMP[j+11], temp_BMP[j+12], temp_BMP[j+13], temp_BMP[j+14], temp_BMP[j+15], temp_BMP[j+16], temp_BMP[j+17], temp_BMP[j+18], temp_BMP[j+19], temp_BMP[j+20],temp_BMP[j+21],temp_BMP[j+22],temp_BMP[j+23],temp_BMP[j+24],temp_BMP[j+25],temp_BMP[j+26],temp_BMP[j+27],temp_BMP[j+28],temp_BMP[j+29],temp_BMP[j+30],temp_BMP[j+31],
             16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0,16'b0, 
             temp_xout[j/32], temp_yout[j/32], clk);//store the output in each index of the temp_x/yout array
      
        end
    endgenerate
    
    //COLUMN
    //we will use generate block to call the 1D FFT module over each column of the previously calculated row FFT data
    wire signed[511:0]temp_x1[0:31]; //512 is the no. of bits in the output of a 1D FFT with input 32inputs each of 16 bits
    wire signed[511:0]temp_y1[0:31];
    
    //we will use generate block to call the 1D FFT module over each column
    genvar k;
    generate
        //increment the k value by 16 each time to proceed to the next column
        //the for loop will iterate till all the column value are processed in the 1-D FFT

        for(k=0; k<512; k=k+16)begin: column
                     
            main_cordic_fft  column_FFT(temp_xout[0][k+15:k],temp_xout[1][k+15:k],temp_xout[2][k+15:k],temp_xout[3][k+15:k],temp_xout[4][k+15:k],temp_xout[5][k+15:k],temp_xout[6][k+15:k],temp_xout[7][k+15:k],temp_xout[8][k+15:k],temp_xout[9][k+15:k],temp_xout[10][k+15:k],temp_xout[11][k+15:k],temp_xout[12][k+15:k],temp_xout[13][k+15:k],temp_xout[14][k+15:k],temp_xout[15][k+15:k],temp_xout[16][k+15:k],temp_xout[17][k+15:k],temp_xout[18][k+15:k],temp_xout[19][k+15:k],temp_xout[20][k+15:k],temp_xout[21][k+15:k],temp_xout[22][k+15:k],temp_xout[23][k+15:k],temp_xout[24][k+15:k],temp_xout[25][k+15:k],temp_xout[26][k+15:k],temp_xout[27][k+15:k],temp_xout[28][k+15:k],temp_xout[29][k+15:k],temp_xout[30][k+15:k],temp_xout[31][k+15:k], 
                temp_yout[0][k+15:k],temp_yout[1][k+15:k],temp_yout[2][k+15:k],temp_yout[3][k+15:k],temp_yout[4][k+15:k],temp_yout[5][k+15:k],temp_yout[6][k+15:k],temp_yout[7][k+15:k],temp_yout[8][k+15:k],temp_yout[9][k+15:k],temp_yout[10][k+15:k],temp_yout[11][k+15:k],temp_yout[12][k+15:k],temp_yout[13][k+15:k],temp_yout[14][k+15:k],temp_yout[15][k+15:k],temp_yout[16][k+15:k],temp_yout[17][k+15:k],temp_yout[18][k+15:k],temp_yout[19][k+15:k],temp_yout[20][k+15:k],temp_yout[21][k+15:k],temp_yout[22][k+15:k],temp_yout[23][k+15:k],temp_yout[24][k+15:k],temp_yout[25][k+15:k],temp_yout[26][k+15:k],temp_yout[27][k+15:k],temp_yout[28][k+15:k],temp_yout[29][k+15:k],temp_yout[30][k+15:k],temp_yout[31][k+15:k],
                temp_x1[k/16], temp_y1[k/16], clk);//store the output in each index of the temp_x1/y1 array
           
        end
    endgenerate
    
    //finaly concatenate the temporary values in the wire array to a single xout(real) and yout(imaginary)
    assign xout = {temp_x1[31],temp_x1[30],temp_x1[29],temp_x1[28],temp_x1[27],temp_x1[26],temp_x1[25],temp_x1[24],temp_x1[23],temp_x1[22],temp_x1[21],temp_x1[20],temp_x1[19],temp_x1[18],temp_x1[17],temp_x1[16],temp_x1[15],temp_x1[14],temp_x1[13],temp_x1[12],temp_x1[11],temp_x1[10],temp_x1[9],temp_x1[8],temp_x1[7],temp_x1[6],temp_x1[5],temp_x1[4],temp_x1[3],temp_x1[2],temp_x1[1],temp_x1[0]};
    assign yout = {temp_y1[31],temp_y1[30],temp_y1[29],temp_y1[28],temp_y1[27],temp_y1[26],temp_y1[25],temp_y1[24],temp_y1[23],temp_y1[22],temp_y1[21],temp_y1[20],temp_y1[19],temp_y1[18],temp_y1[17],temp_y1[16],temp_y1[15],temp_y1[14],temp_y1[13],temp_y1[12],temp_y1[11],temp_y1[10],temp_y1[9],temp_y1[8],temp_y1[7],temp_y1[6],temp_y1[5],temp_y1[4],temp_y1[3],temp_y1[2],temp_y1[1],temp_y1[0]};
    
endmodule

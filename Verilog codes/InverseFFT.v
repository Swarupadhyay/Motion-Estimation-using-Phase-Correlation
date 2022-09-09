`timescale 1ns / 1ps

module Inverse_fft(clk, xfinal, yfinal, xout_inv, yout_inv);
//module Inverse_fft(clk, xout_inv, yout_inv);

parameter N = 16384;

input clk;

input signed [N-1:0]xfinal;
input signed [N-1:0]yfinal;

// INPUT MATRIX STORED ---- 32 * 32 elements each of 16 bits
// Imaginary part = 0
//reg signed [N-1:0]xfinal;
//reg signed [N-1:0]yfinal = 0;

// OUTPUT MATRIX STORED (AFTER INVERSE)---- 32 * 32 elements each of 16 bits
output signed [N-1:0]xout_inv, yout_inv;


// TESTING MATRIX
//parameter INFILE = "C:/Users/Paras Gupta/project_fft_twodim/project_fft_twodim.srcs/sources_1/new/hex.hex";
    
//    reg signed [15:0] temp_BMP [0 : 1023];
    
//    initial begin
//    $readmemh(INFILE,temp_BMP,0,1023); // read file from INFILE
//    end
    
//    integer i;
//    initial begin
//            for(i=0; i<N ; i=i+16) begin //32x32 = 1024
//                xfinal[i+:16] = temp_BMP[i/16]/32;
//                   //xfinal[i+:16] = 1000;
//            end
            
//            //$display("%b",temp_BMP[2]);
            
//    end

////INVERSE FFT

// Temporary Variables (arrays here) to store the intermediate matrix after 1D FFT looped over the columns
wire signed [511:0]temp_xout[0:31];
wire signed [511:0]temp_yout[0:31];

//genvar j;
//generate
//    for(j=0; j<N; j=j+512)begin: column
//        main_inverse_fft column_ifft(xfinal[j+15:j],xfinal[j+31:j+16],xfinal[j+47:j+32],xfinal[j+63:j+48], xfinal[j+79:j+64], xfinal[j+95:j+80], xfinal[j+111:j+96], xfinal[j+127:j+112],xfinal[j+143:j+128],xfinal[j+159:j+144],xfinal[j+175:j+160],xfinal[j+191:j+176],xfinal[j+207:j+192],xfinal[j+223:j+208],xfinal[j+239:j+224],xfinal[j+255:j+240],xfinal[j+271:j+256],xfinal[j+287:j+272],xfinal[j+303:j+288],xfinal[j+319:j+304],xfinal[j+335:j+320],xfinal[j+351:j+336],xfinal[j+367:j+352],xfinal[j+383:j+368],xfinal[j+399:j+384],xfinal[j+415:j+400],xfinal[j+431:j+416],xfinal[j+447:j+432],xfinal[j+463:j+448],xfinal[j+479:j+464],xfinal[j+495:j+480],xfinal[j+511:j+496],
//        yfinal[j+15:j],yfinal[j+31:j+16],yfinal[j+47:j+32],yfinal[j+63:j+48], yfinal[j+79:j+64], yfinal[j+95:j+80], yfinal[j+111:j+96], yfinal[j+127:j+112],yfinal[j+143:j+128],yfinal[j+159:j+144],yfinal[j+175:j+160],yfinal[j+191:j+176],yfinal[j+207:j+192],yfinal[j+223:j+208],yfinal[j+239:j+224],yfinal[j+255:j+240],yfinal[j+271:j+256],yfinal[j+287:j+272],yfinal[j+303:j+288],yfinal[j+319:j+304],yfinal[j+335:j+320],yfinal[j+351:j+336],yfinal[j+367:j+352],yfinal[j+383:j+368],yfinal[j+399:j+384],yfinal[j+415:j+400],yfinal[j+431:j+416],yfinal[j+447:j+432],yfinal[j+463:j+448],yfinal[j+479:j+464],yfinal[j+495:j+480],yfinal[j+511:j+496],        
//        temp_xout[j/512],temp_yout[j/512], clk);   
//    end
//endgenerate


// Genearte block used to iterate over the columns of the input matrix
// 1D FFT Module called in each iteration 
// Inputs of 1D FFT(forward FFT) changed to accomodate conjugates of the inputs 
// Output generated ----> 1D Inverse FFT of each column 
// Conjuagtion of output not done in this step as it is the input to the next generate block, which again requires conjugation
//   ~(~a) = a

genvar j;
generate
    for(j=0; j<N; j=j+512)begin: column
        main_cordic_fft column_ifft(xfinal[j+15:j],xfinal[j+31:j+16],xfinal[j+47:j+32],xfinal[j+63:j+48], xfinal[j+79:j+64], xfinal[j+95:j+80], xfinal[j+111:j+96], xfinal[j+127:j+112],xfinal[j+143:j+128],xfinal[j+159:j+144],xfinal[j+175:j+160],xfinal[j+191:j+176],xfinal[j+207:j+192],xfinal[j+223:j+208],xfinal[j+239:j+224],xfinal[j+255:j+240],xfinal[j+271:j+256],xfinal[j+287:j+272],xfinal[j+303:j+288],xfinal[j+319:j+304],xfinal[j+335:j+320],xfinal[j+351:j+336],xfinal[j+367:j+352],xfinal[j+383:j+368],xfinal[j+399:j+384],xfinal[j+415:j+400],xfinal[j+431:j+416],xfinal[j+447:j+432],xfinal[j+463:j+448],xfinal[j+479:j+464],xfinal[j+495:j+480],xfinal[j+511:j+496],
        -yfinal[j+15:j],-yfinal[j+31:j+16],-yfinal[j+47:j+32],-yfinal[j+63:j+48],- yfinal[j+79:j+64], -yfinal[j+95:j+80], -yfinal[j+111:j+96], -yfinal[j+127:j+112],-yfinal[j+143:j+128],-yfinal[j+159:j+144],-yfinal[j+175:j+160],-yfinal[j+191:j+176],-yfinal[j+207:j+192],-yfinal[j+223:j+208],-yfinal[j+239:j+224],-yfinal[j+255:j+240],-yfinal[j+271:j+256],-yfinal[j+287:j+272],-yfinal[j+303:j+288],-yfinal[j+319:j+304],-yfinal[j+335:j+320],-yfinal[j+351:j+336],-yfinal[j+367:j+352],-yfinal[j+383:j+368],-yfinal[j+399:j+384],-yfinal[j+415:j+400],-yfinal[j+431:j+416],-yfinal[j+447:j+432],-yfinal[j+463:j+448],-yfinal[j+479:j+464],-yfinal[j+495:j+480],-yfinal[j+511:j+496],        
        temp_xout[j/512],temp_yout[j/512], clk);   
    end
endgenerate


// Temporary Variables (arrays here) to store the final matrix after 1D FFT looped over the rows
wire signed [511:0]temp_x1[0:31];
wire signed [511:0]temp_y1[0:31];


// Genearte block used to iterate over the rows of the temporary matrix
// 1D FFT Module called in each iteration 
// Inputs of 1D FFT(forward FFT) changed to accomodate conjugates of the inputs 
// Output generated ----> 1D Inverse FFT of each row 
genvar k;
generate
    for(k=0; k<512; k=k+16)begin: row                    
            main_inverse_fft  row_ifft(temp_xout[0][k+15:k],temp_xout[1][k+15:k],temp_xout[2][k+15:k],temp_xout[3][k+15:k],temp_xout[4][k+15:k],temp_xout[5][k+15:k],temp_xout[6][k+15:k],temp_xout[7][k+15:k],temp_xout[8][k+15:k],temp_xout[9][k+15:k],temp_xout[10][k+15:k],temp_xout[11][k+15:k],temp_xout[12][k+15:k],temp_xout[13][k+15:k],temp_xout[14][k+15:k],temp_xout[15][k+15:k],temp_xout[16][k+15:k],temp_xout[17][k+15:k],temp_xout[18][k+15:k],temp_xout[19][k+15:k],temp_xout[20][k+15:k],temp_xout[21][k+15:k],temp_xout[22][k+15:k],temp_xout[23][k+15:k],temp_xout[24][k+15:k],temp_xout[25][k+15:k],temp_xout[26][k+15:k],temp_xout[27][k+15:k],temp_xout[28][k+15:k],temp_xout[29][k+15:k],temp_xout[30][k+15:k],temp_xout[31][k+15:k], 
            temp_yout[0][k+15:k],temp_yout[1][k+15:k],temp_yout[2][k+15:k],temp_yout[3][k+15:k],temp_yout[4][k+15:k],temp_yout[5][k+15:k],temp_yout[6][k+15:k],temp_yout[7][k+15:k],temp_yout[8][k+15:k],temp_yout[9][k+15:k],temp_yout[10][k+15:k],temp_yout[11][k+15:k],temp_yout[12][k+15:k],temp_yout[13][k+15:k],temp_yout[14][k+15:k],temp_yout[15][k+15:k],temp_yout[16][k+15:k],temp_yout[17][k+15:k],temp_yout[18][k+15:k],temp_yout[19][k+15:k],temp_yout[20][k+15:k],temp_yout[21][k+15:k],temp_yout[22][k+15:k],temp_yout[23][k+15:k],temp_yout[24][k+15:k],temp_yout[25][k+15:k],temp_yout[26][k+15:k],temp_yout[27][k+15:k],temp_yout[28][k+15:k],temp_yout[29][k+15:k],temp_yout[30][k+15:k],temp_yout[31][k+15:k],
             temp_x1[k/16], temp_y1[k/16], clk);     
        end             
    endgenerate

// FINAL OUTPUT (single output)---> concatenations of the various rows stored in the temporary arrays
assign xout_inv = {temp_x1[31],temp_x1[30],temp_x1[29],temp_x1[28],temp_x1[27],temp_x1[26],temp_x1[25],temp_x1[24],temp_x1[23],temp_x1[22],temp_x1[21],temp_x1[20],temp_x1[19],temp_x1[18],temp_x1[17],temp_x1[16],temp_x1[15],temp_x1[14],temp_x1[13],temp_x1[12],temp_x1[11],temp_x1[10],temp_x1[9],temp_x1[8],temp_x1[7],temp_x1[6],temp_x1[5],temp_x1[4],temp_x1[3],temp_x1[2],temp_x1[1],temp_x1[0]};
assign yout_inv = {-temp_y1[31],-temp_y1[30],-temp_y1[29],-temp_y1[28],-temp_y1[27],-temp_y1[26],-temp_y1[25],-temp_y1[24],-temp_y1[23],-temp_y1[22],-temp_y1[21],-temp_y1[20],-temp_y1[19],-temp_y1[18],-temp_y1[17],-temp_y1[16],-temp_y1[15],-temp_y1[14],-temp_y1[13],-temp_y1[12],-temp_y1[11],-temp_y1[10],-temp_y1[9],-temp_y1[8],-temp_y1[7],-temp_y1[6],-temp_y1[5],-temp_y1[4],-temp_y1[3],-temp_y1[2],-temp_y1[1],-temp_y1[0]};    

    
endmodule
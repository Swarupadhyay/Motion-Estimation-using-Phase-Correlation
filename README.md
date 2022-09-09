# Motion-Estimation-using-Phase-Correlation

Motion Estimation using Phase Correlation on FPGA

Motion estimation is the process of determining motion vectors that describe the transformation from one 2D image to another; usually from adjacent frames in a video sequence. However in this case, where we will implement motion estimation in an FPGA board, our motive is to study and analyse two consecutive frames and implement the motion estimation model there.

The algorithm we will be using is Phase Correlation. Every image pixel can be represented mathematically as a combination of sine and cosine wave functions. We will implement the above using the Fast Fourier Transform algorithm(DFT), iterating over each of the image pixel values (conversion from spatial to frequency domain).

We will primarily concentrate on the estimating the motion in grayscale images as they involve the use of 2-D Fourier Transform. Moreover, the motion estimation would be almost the same for both RGB and Black and White images.

Considering two images (essentially the two consecutive frames of a motion video), in which one of them has undergone a linear shift, the aim is to find the displacement of the image vectors using the above algorithm.

We have used the following two images as the input image:-

![temp](https://user-images.githubusercontent.com/63966378/189429718-708bf275-106a-4417-a908-319769f61b62.png)

The final output as in the above image (phase correlation) shows a point that represents the displacement of the pixel coordinates from the first frame to the next, when compared to the origin of the first frame.

The 3 layers of implementation in our project involve Cordic functions, FastFourier Transform(forward and reverse) and finally the combination of the defined modules, after their implementation on FPGA, to estimate the motion.

The offset in the translated image can be easily pointed out by inspecting the brightness peak of the Output Hotspot. A Bright peak can be seen in the top left corner of the resultant image. This region signifies the shift in the original frame from the corresponding next frame.

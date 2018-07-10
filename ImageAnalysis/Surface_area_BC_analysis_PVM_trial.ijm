//Program description: This macro does the bile canaliculi (BC) thersholding and segments the PVM, infected cell & five uninfected cells. The surface area of BC on PVM, infected cell & uninfected cells are being calculated.
//Other parameters like volume, area of segmented objects are also being calculated. 
//Segmentation of PVM, infected & uninfected cells (5) are being carried manually. So the macro is interactive for the segmentation.
//INPUT: Z-stack images with four channels (One image at a time); OUTPUT: 14 .csv files & 15 .avi files are generated for one image
//TIPS: Before choosing the input image user should check the channel numbers for the four channels. The channel number could be changed according to the choosen image in the lines with "$" symbol where the channel number is specified.

//The earlier surface area BC analysis script is modified because there is the GFP fluoresence of parasite in CD13 channel.
//In this new modified script using PVM mask I have removed that from the thresholded CD13 image.

//*********************************************************************************************************************************************************************************************************************************************************************************************************************

//-------------------------------------------------------------------------------------------------------------------------------------------------
/*
//Segmentation of PVM using segmentation editor; Saving the obtained results file (volume of the PVM, Surface area of bile canaliculi on PVM) as .csv in the output folder

selectWindow("C1-dupli_image"); //$ UIS4/PVM channel
run("Red");
run("Smooth", "stack");
run("Smooth", "stack");
setTool("freehand");
waitForUser("Segmentation Editor: Segment the PVM", "(1)Uncheck 3D option (2)Segment PVM manually from few random slices (3)Click 'I' (4)Check 3D (5)Click '+' (6)Finally click OK"); 
run("Segmentation Editor");
wait(1000);
selectWindow("C1-dupli_image.labels"); //$ UIS4/PVM channel
rename("PVM.labels");

//Saving the segmented PVM as a mask
run("AVI... ", "compression=JPEG frame=10 save=["+output1+"PVM.labels.avi]");

selectWindow("PVM.labels");
run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
//selectWindow("Statistics for PVM.labels");
saveAs("Results", output1+"statistics_PVM.csv"); 
selectWindow("PVM.labels");
*/
selectWindow("PVM.labels.avi");
//This steps is to duplicate the PVM mask & threshold it to convert to binary. It was 0 & 1. Multiply the image with 255 to make it 0 & 255.
//run("Duplicate...", "duplicate");
run("Duplicate...", "title=PVM.labels-1 duplicate");
//run("Threshold...");
//wait(1000); 
//setAutoThreshold("Default dark");
setThreshold(45, 255);
//waitForUser("Threshold", "Please adjust threshold and then click OK");
//run("Multiply...", "value=255.000 stack");
run("Make Binary", "method=Default background=Default");


/*
//Subtract the PVM mask(0 & 255) from thresholded CD13 resulting in the new dupli image of CD13.
//This resultant image is used in further step to identify BC on PVM & hepatocytes.
selectWindow("C2-dupli_image");
run("Duplicate...", "duplicate");
//selectWindow("C2-dupli_image");
//close();
imageCalculator("Subtract create stack", "C2-dupli_image-1","PVM.labels-1");
selectWindow("Result of C2-dupli_image-1");
run("Duplicate...", "duplicate");
saveAs("Tiff", output1+"PVM_mask_C2-dupli_image.tif");
selectWindow("Result of C2-dupli_image-1");
*/
selectWindow("PVM_mask_C2-dupli_image.tif");
rename("C2-dupli_image-2");

selectWindow("PVM.labels-1");
run("Dilate", "stack");
imageCalculator("Subtract create stack", "PVM.labels-1","C2-dupli_image-2"); //$ CD13/BC channel
selectWindow("Result of PVM.labels-1");
rename("Result of PVM.labels1");
close("Result of PVM.labels-1");
imageCalculator("Subtract create stack", "PVM.labels-1","Result of PVM.labels1");
selectWindow("Result of PVM.labels-1");
rename("PVM_BC_surface");
run("Duplicate...", "title=PVM_BC_surface_mask duplicate");
//saveAs("Tiff", output1+ "PVM_BC_surface_mask.tif");
//Saving the BC mask that is on the surface of the PVM
//run("AVI... ", "compression=JPEG frame=10 save=["+output1+"PVM_BC_surface.avi]");

close("Result of PVM.labels");
selectWindow("PVM_BC_surface");

getStatistics(area, mean, min, max, std, histogram);
print (max);
if (max < 128) threshold = max;
else threshold = 128;
print ("Using threshold of " + threshold);
run("3D Objects Counter", "threshold=" + threshold +
      " slice=50 min.=10 max.=2124276 " +
      "objects surfaces centroids centres_of_masses statistics summary");
     
//run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
//selectWindow("Statistics for PVM_BC_surface");
//saveAs("Results",output1+"statistics_PVM_surfacearea_BC.csv");

selectWindow("PVM_BC_surface");
/*
//Closing all the windows that are opened during the processing of 3D object counter. If these windows are opened it consumes lot of memory & further processing becomes difficult.
close("C1-dupli_image"); //$ UIS4/PVM channel
close("PVM.labels");
close("Objects map of PVM.labels");
close("Surface map of PVM.labels");
close("Centroids map of PVM.labels");
close("Centres of mass map of PVM.labels");
close("PVM_BC_surface");
close("Objects map of PVM_BC_surface");
close("Surface map of PVM_BC_surface");
close("Centroids map of PVM_BC_surface");
close("Centres of mass map of PVM_BC_surface");
close("PVM.labels-1");
//-------------------------------------------------------------------------------------------------------------------------------------------------

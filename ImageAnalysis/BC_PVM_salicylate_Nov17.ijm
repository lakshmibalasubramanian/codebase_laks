//Program description: This macro does the bile canaliculi (BC) thersholding and segments the PVM, infected cell & five uninfected cells. The surface area of BC on PVM, infected cell & uninfected cells are being calculated.
//Other parameters like volume, area of segmented objects are also being calculated. 
//Segmentation of PVM, infected & uninfected cells (5) are being carried manually. So the macro is interactive for the segmentation.
//INPUT: Z-stack images with four channels (One image at a time); OUTPUT: 14 .csv files & 15 .avi files are generated for one image
//TIPS: Before choosing the input image user should check the channel numbers for the four channels. The channel number could be changed according to the choosen image in the lines with "$" symbol where the channel number is specified.

//*********************************************************************************************************************************************************************************************************************************************************************************************************************

//Open the image containing folder and creates the output folder. This is based on the user selection
filepath=File.openDialog("Select input image"); 
image= File.getName(filepath);
output = getDirectory("Choose output directory");
//out_dir = image+"_result";
file=File.makeDirectory(output+image+"_result");
output1 = output+image+"_result/";

//This print command just prints the output directory (where all the .avi & .csv files are saved
//print (output1);

//-------------------------------------------------------------------------------------------------------------------------------------------------

//Open the image and do the preliminary steps like duplicating & splitting channels. Closing the unwanted channels

open(filepath);
selectWindow(image);
run("Duplicate...", "title=dupli_image duplicate");
run("Split Channels");
selectWindow("C3-dupli_image"); //$ DAPI channel
close();
selectWindow(image);
close();

//-------------------------------------------------------------------------------------------------------------------------------------------------

//Choose CD13 channel (BC). Preprocessing steps for the image. Thersholding BC

selectWindow("C1-dupli_image"); //$ CD13/BC channel
run("Green");
run("Smooth", "stack");
run("Smooth", "stack");
run("Threshold...");
wait(1000); 
setAutoThreshold("Default dark");
waitForUser("Threshold", "Please adjust threshold and then click OK"); 
run("Convert to Mask", "stack");
run("Dilate", "stack");
run("Dilate", "stack");
run("Erode", "stack");
run("Fill Holes", "stack");

//Saving the thresholded BC as avi file. Not saving it a tif because, the saved tif is not able to be used for further steps directly & also its file size is higher than avi.

run("AVI... ", "frame=10 save=["+output1+"C1-dupli_image.avi]"); //$ CD13/BC channel

//-------------------------------------------------------------------------------------------------------------------------------------------------

//Segmentation of PVM using segmentation editor; Saving the obtained results file (volume of the PVM, Surface area of bile canaliculi on PVM) as .csv in the output folder

selectWindow("C2-dupli_image"); //$ UIS4/PVM channel
run("Red");
run("Smooth", "stack");
run("Smooth", "stack");
setTool("freehand");
waitForUser("Segmentation Editor: Segment the PVM", "(1)Uncheck 3D option (2)Segment PVM manually from few random slices (3)Click 'I' (4)Check 3D (5)Click '+' (6)Finally click OK"); 
run("Segmentation Editor");
wait(1000);
selectWindow("C2-dupli_image.labels"); //$ UIS4/PVM channel
rename("PVM.labels");

//Saving the segmented PVM as a mask
run("AVI... ", "compression=JPEG frame=10 save=["+output1+"PVM.labels.avi]");

selectWindow("PVM.labels");
run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
selectWindow("Statistics for PVM.labels");
saveAs("Results", output1+"statistics_PVM.csv"); 
selectWindow("PVM.labels");
imageCalculator("Subtract create stack", "PVM.labels","C1-dupli_image"); //$ CD13/BC channel
selectWindow("Result of PVM.labels");
rename("Result of PVM.labels1");
close("Result of PVM.labels");
imageCalculator("Subtract create stack", "PVM.labels","Result of PVM.labels1");
selectWindow("Result of PVM.labels");
rename("PVM_BC_surface");

//Saving the BC mask that is on the surface of the PVM
run("AVI... ", "compression=JPEG frame=10 save=["+output1+"PVM_BC_surface.avi]");

close("Result of PVM.labels");
selectWindow("PVM_BC_surface");
getStatistics(area, mean, min, max, std, histogram);
if (max < 128) threshold = max;
else threshold = 128;
print ("Using threshold of " + threshold);
run("3D Objects Counter", "threshold=" + threshold +
      " slice=50 min.=10 max.=2124276 " +
      "objects surfaces centroids centres_of_masses statistics summary");
//run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
selectWindow("Statistics for PVM_BC_surface");
saveAs("Results",output1+"statistics_PVM_surfacearea_BC.csv");

//Closing all the windows that are opened during the processing of 3D object counter. If these windows are opened it consumes lot of memory & further processing becomes difficult.
close("C2-dupli_image"); //$ UIS4/PVM channel
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


waitForUser("Done successfully!!");
close("*");

//Program description: This macro is to segment the PVM and estimate the surface of bile canaliculi on PVM (This is to estimate from salicylate experiment images 24hpi).
//It estimates SA of BC on PVM. 
//INPUT: Z-stack images with four channels (One image at a time), Thresholded bile canaliculi image; OUTPUT: 2 .csv files & 2 .tif files are generated for one image
//TIPS: Before choosing the input image user should check the channel numbers for the four channels. The channel number could be changed according to the choosen image in the lines with "$" symbol where the channel number is specified.

//*********************************************************************************************************************************************************************************************************************************************************************************************************************

//Open the image containing folder and creates the output folder. This is based on the user selection
filepath=File.openDialog("Select input image"); 
image= File.getName(filepath);
filepath1 = File.openDialog("Select raw BC image");
image_BC = File.getName(filepath1);
output = getDirectory("Choose output directory");
//out_dir = image+"_result";
file=File.makeDirectory(output+image+"_BC_PVM_result");
output1 = output+image+"_BC_PVM_result/";


//This print command just prints the output directory
print (filepath1);

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

open(filepath1);
selectWindow(image_BC);
selectWindow("BC_raw.tif");
run("Smooth", "stack");
run("Threshold...");
wait(1000); 
setAutoThreshold("Default dark");
waitForUser("Threshold", "Please adjust threshold and then click OK"); 
run("Convert to Mask", "stack");
run("Dilate", "stack");
run("Erode", "stack");
selectWindow("BC_raw.tif");
saveAs("Tiff", output1+ "BC_thres.tif");
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
selectWindow("C2-dupli_image-1.labels"); //$ UIS4/PVM channel
rename("PVM.labels");
run("Duplicate...", "title=PVM_mask duplicate");
selectWindow("PVM_mask");

//Saving the segmented PVM as a mask
saveAs("Tiff", output1+ "PVM_mask.tif");

selectWindow("PVM.labels");
run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
selectWindow("Statistics for PVM.labels");
saveAs("Results", output1+"statistics_PVM.csv"); 
selectWindow("PVM.labels");
imageCalculator("Subtract create stack", "PVM.labels","BC_thres.tif"); //$ CD13/BC channel
selectWindow("Result of PVM.labels");
rename("Result of PVM.labels1");
close("Result of PVM.labels");
imageCalculator("Subtract create stack", "PVM.labels","Result of PVM.labels1");
selectWindow("Result of PVM.labels");
rename("PVM_BC_surface");

run("Duplicate...", "title=PVM_BC_surface_mask duplicate");
saveAs("Tiff", output1+ "PVM_BC_surface_mask.tif");

//Saving the BC mask that is on the surface of the PVM

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

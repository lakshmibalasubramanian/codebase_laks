//This program counts the number of small objects in the selected ROIs.
//Here it is used to segment (3D) & count the small number of parasite inside the PVM
//Inputs: PVM mask (here as .avi file), Raw image (Z-stack) (for Nuclei channel)
//Outputs: 3 .tif files, 1 .csv file
//TIPS: Before choosing the input image user should check the channel numbers for the four channels.
//The channel number could be changed according to the choosen image in the lines with "$" symbol where the channel number is specified.
//**********************************************************************************************************************************************

//Open raw image and creates the output folder
filepath=File.openDialog("Select input image"); 
image= File.getName(filepath);
filepath_new=File.openDialog("Select input image: PVM mask");
image_PVM_mask=File.getName(filepath_new);
output = getDirectory("Choose output directory");
file=File.makeDirectory(output+image+"_parasitecount_result");
output1 = output+image+"_parasitecount_result/";
print (output1); //This output is printed in log window

//----------------------------------------------------------------------------------------------------

//Opening the raw image and duplicating & channel splitting; Select the DAPI channel
open(filepath_new);
open(filepath);
selectWindow(image);
run("Duplicate...", "title=dupli_image duplicate");
run("Split Channels");
selectWindow(image);
close();
selectWindow("C3-dupli_image"); //$ DAPI channel

//----------------------------------------------------------------------------------------------------

//Applying median filter to the raw image; Thresholding the nuclei channel; Saving it as a mask
run("Duplicate...", "title=DAPI.tif duplicate");
run("Median 3D...", "x=1.5 y=1.5 z=1.5");
run("Threshold...");
wait(1000); 
setAutoThreshold("Default dark");
waitForUser("Threshold", "Please adjust threshold and then click OK"); 
run("Convert to Mask", "stack");
run("Dilate", "stack");
run("Erode", "stack");
run("Fill Holes", "stack");
saveAs("Tiff", output1+ "DAPI.tif");

//----------------------------------------------------------------------------------------------------

//converting the PVM mask to binary image (from .avi which is RGB)
selectWindow(image_PVM_mask);
run("8-bit");
run("Threshold...");
wait(500);
setAutoThreshold("Default dark");
waitForUser("Threshold", "1.Click auto from Threshold window. 2. Check the slices if the autothresholding is fine 3. click OK");
run("Make Binary", "method=Default background=Dark calculate");
saveAs("Tiff", output1+ "PVM_mask.tif");
selectWindow("PVM_mask.tif");

//----------------------------------------------------------------------------------------------------

//Generating the ROIs of the PVM masks from the binary image.
run("Analyze Particles...", "clear add stack");
w=getWidth(); 
h=getHeight(); 
s=nSlices(); 
print (s);
newImage("Mask", "8-bit Black", w, h, s); //Generating the new blank image
setForegroundColor(255, 255, 255); 
nb=roiManager("count"); 
for(i=0;i<nb;i++) { 
        roiManager("Select",i); //Getting the ROIs in the new image & fill it (for each slice)
run("Fill", "slice"); 
} 

//----------------------------------------------------------------------------------------------------

//Applying the ROI mask in the nuclei channel (Thresholded)
imageCalculator("Multiply create stack", "DAPI.tif","Mask");
selectWindow("Result of DAPI.tif");

//----------------------------------------------------------------------------------------------------

//Segmentation in 3D using 3D object counter; Get the statistics for each of the small parasite inside the PVM mask
//Saving the computed output as a .csv & 3D segmentation as .tif
run("3D Manager");
Ext.Manager3D_Segment(128, 255);

Ext.Manager3D_AddImage();
Ext.Manager3D_Measure();
Ext.Manager3D_SaveResult("M", output1+ "Results3D.csv");
run("Random");
saveAs("Tiff", output1+ "3Dseg.tif");
close("3D Manager");

//----------------------------------------------------------------------------------------------------

//Clearing the ROIs and closing all the images
roiManager("Select All");
roiManager("Delete");
run("Close");

waitForUser("Done successfully!!");
run("Close All");


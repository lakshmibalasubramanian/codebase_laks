///Program description: This macro is to extract information about Bile Canaliculi (BC) like total length, volume, branch lengths, diameter etc...
///This macro is built to analyse the salicylate experiment. Basically to capture the difference in the BC in case salicylate treatd and non-treated condition.
///INPUT: Z-stack images; OUTPUT: 2 .csv files & 5 .tif files are generated for one image
///TIPS: Before choosing the input image user should check the channel numbers for the four channels. The channel number could be changed according to the choosen image in the lines with "$" symbol where the channel number is specified.
///TIPS: Always close the log window before running the macro for every image.
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


//Open the image containing folder and creates the output folder. 
filepath=File.openDialog("Select input image: BC raw image");
image_BC_raw= File.getName(filepath);
output = getDirectory("Choose output directory");
filepath_new=File.openDialog("Select input image: BC surface area mask");
image_BC_SA_mask=File.getName(filepath_new);

//file=File.makeDirectory(output+"Tubeness_BC_uninf_expand_5_result_try");
file=File.makeDirectory(output+"Tubeness_BC_uninf_expand_7_result");
output1 = output+"Tubeness_BC_uninf_expand_7_result\\";
//output1 = output+"Tubeness_BC_inf_expand_7_result\\";

//Open the image and do the preliminary steps like duplicating, splitting channels, smoothing etc..Also close the unwanted channels
open(filepath);
selectWindow(image_BC_raw);
open(filepath_new);
selectWindow(image_BC_SA_mask);
//selectWindow("Infec_Cells_BC_surface_expand_7.tif");
selectWindow("1Uninfec_Cells_BC_surface_expand_7.tif");
//run("8-bit");
//setAutoThreshold("Default dark");
//run("Convert to Mask", "method=Default background=Default calculate");
 
run("Duplicate...", "title=dupli_inf_BC_roi.tif duplicate");

//run("Threshold...");
setThreshold(1, 255);
//wait(500); 
//waitForUser("Threshold", "Please adjust threshold and then click OK");

run("Analyze Particles...", "  show=Outlines display exclude add in_situ stack");
roiManager("Show None");
selectWindow("BC_raw.tif");


roiManager("Show All");
selectWindow("dupli_inf_BC_roi.tif");
//selectWindow("Infec_Cells_BC_surface_expand_7.tif");
selectWindow("1Uninfec_Cells_BC_surface_expand_7.tif");
roiManager("Show All");
roiManager("Show None");
roiManager("Show All");
selectWindow("BC_raw.tif");
//imageCalculator("Multiply create stack", "BC_raw.tif","Infec_Cells_BC_surface_expand_7.tif");
imageCalculator("Multiply create stack", "BC_raw.tif","1Uninfec_Cells_BC_surface_expand_7.tif");
selectWindow("Result of BC_raw.tif");
//selectWindow("Infec_Cells_BC_surface_expand_7.tif");
selectWindow("1Uninfec_Cells_BC_surface_expand_7.tif");
//imageCalculator("Divide create stack", "Result of BC_raw.tif","Infec_Cells_BC_surface_expand_7.tif");
imageCalculator("Divide create stack", "Result of BC_raw.tif","1Uninfec_Cells_BC_surface_expand_7.tif");
selectWindow("Result of Result of BC_raw.tif");
run("Invert", "stack");



///Getting the pixel size of the image///
getPixelSize(unit,px,py,pz);
//print (unit,px,py,pz);

///Initialization of parameters///
//Creating the dialog boxes and feeding the parameters
Dialog.create("Parameters for analysis");
Dialog.addNumber("Bile radius for closure ("+unit+")", 1.2);          //Give the approximate radius of the bile ~1-1.2; This is basically the estimate of how much we have close the bile
Dialog.addNumber("Sigma radius for tubeness ("+unit+")", 1.0);       //Sigma is the value for gaussian pre-filter which is before calculating tubeness; For this set of images 1.0 works fine
Dialog.addNumber("Minimum tube volume (pixels)", 1000);
Dialog.addCheckbox("Remove branches with end-points", false); 
Dialog.addNumber("Dilate Skeleton for viewing by (pixels)", 2);
Dialog.addNumber("Number of threads", 8);                          //Ensure the number of threads available in the respective machine.
Dialog.show;
//Assigning all the parameters in the variables
ClosingRadius = Dialog.getNumber();
SigmaRadius = Dialog.getNumber();  
//TubeThreshold = Dialog.getNumber();
TubeVolumeThreshold = Dialog.getNumber();
PruneEnds = Dialog.getCheckbox();
VisualisationDilation = Dialog.getNumber();
Nthreads = Dialog.getNumber();

///Closure of the bile tubes///
run("3D Fast Filters","filter=CloseGray radius_x_pix="+d2s(ClosingRadius/px,2)+" radius_y_pix="+d2s(ClosingRadius/py,2)+" radius_z_pix="+d2s(ClosingRadius/pz,2)+" Nb_cpus="+d2s(Nthreads,0));
rename("Closed.tif");
saveAs("Tiff",output1+"Closed.tif");


///Calculating the Tubeness of BC///
selectImage("Closed.tif");
run("Tubeness", "sigma="+d2s(SigmaRadius,3.0)+" use");     //Sigma 3.0 works better with the created mask
rename("Tubeness.tif");
saveAs("Tiff",output1+"Tubeness.tif");

///Segmentation of BC using the tubeness determined image///
selectImage("Tubeness.tif");
// Convert the 32-bit Tubeness image to 8-bit for thresholding
Stack.getStatistics(voxelCount, mean, min, max);
setMinAndMax(min,max);
run("8-bit");

///Thresholding///Need be careful in doing manual thresholding beacuse based on this only number of branches, length & volume will be calculated.
//run("Threshold...");
setThreshold(63, 255);
//wait(500); 
//setAutoThreshold("Default dark");
//waitForUser("Threshold", "Please adjust threshold and then click OK");
run("Convert to Mask", "method=Default background=Dark"); 
setSlice(nSlices/2); // move to central slices (only for nice viewing)

// Find connected components, remove too small objects and apply Random LUT
run("3D OC Options", "volume nb_of_obj._voxels dots_size=5 font_size=10 redirect_to=none"); //  to ensure that ResultsTable is named "Results", i.e. uncheck the "macro friendly" naming
run("3D Objects Counter", "threshold=128 min.="+d2s(TubeVolumeThreshold,2)+" max.="+d2s(nSlices*getWidth()*getHeight(),0)+" objects statistics summary");
run("glasbey inverted"); // run("Random") // change LUT 
rename("LabelMask.tif");
saveAs("Tiff",output1+"LabelMask.tif");
selectWindow("Results"); 
IJ.renameResults("Results","Volume_Results.xls");
saveAs("Volume_Results.xls", output1+"Volume_Results.xls");
run("Close"); 

///Converting to binary image///
selectImage("LabelMask.tif");
run("Duplicate...", "title=BinarizedTubes.tif duplicate"); // work on duplicate as we need the Labelmask later
run("8-bit");
setThreshold(1,255);
run("Convert to Mask", "method=Default background=Dark");

// Skeletonisation
run("Duplicate...", "title=Skeleton duplicate"); // work on duplicate
run("Skeletonize (2D/3D)");
rename("Skeleton.tif");
saveAs("Tiff",output1+"Skeleton.tif");

// Remove end-point branches by pruning
if(PruneEnds) run("Analyze Skeleton (2D/3D)", "prune=none prune"); // no circular pruning, but end-point pruning
else run("Analyze Skeleton (2D/3D)", "prune=none"); // no circular pruning, no end-point pruning
IJ.renameResults("Results","Skeleton_Results.xls");
run("Fire");
rename("ThickSkeleton.tif");
saveAs("Tiff",output1+"ThickSkeleton.tif");


/// Extraction of relevant parameters///

// Total BC length
IJ.renameResults("Skeleton_Results.xls", "Results"); // make table accessible
totalLength = 0;
nBranches = 0;
for(i=0; i<nResults; i++) {
	totalLength = totalLength + getResult("# Branches", i)*getResult("Average Branch Length", i);
	nBranches = nBranches + getResult("# Branches", i);	
}
saveAs("Results", output1+"Skeleton_Results.xls");

// Total imaged and BC tube volumes
selectWindow("BinarizedTubes.tif"); // image containing the segmented BC
Stack.getStatistics(voxelCount, mean, min, max, stdDev);
//getVoxelSize(width, height, depth, unit);
totalImagedVolume = voxelCount*px*py*pz;
totalVolume = voxelCount*mean/255*px*py*pz;

// Mean BC crosssection and diameter
meanCrosssection = totalVolume / totalLength;
meanDiameter = 2*sqrt(meanCrosssection/PI);

print("------------------------------------------------------------------------------------------------------------------------------");
print("///Results for the image: "+image_BC_raw+"///");
print("-----------------------------------------------------------------------");
print("Total length = " + d2s(totalLength,2) + " " + unit);
print("Number of branches = " + d2s(nBranches,0) );
print("Average branch length = " + d2s(totalLength/nBranches,2) + " " + unit);
print("Total BC volume = " + d2s(totalVolume,2) + " " + unit + "^3" );
print("Mean BC (tube) diameter = " + d2s(meanDiameter,2) + " " + unit);
print("Mean BC (tube) cross-section = " + d2s(meanCrosssection,2) + " " + unit + "^2");
print("Total imaged volume = " + d2s(totalImagedVolume,2) + " " + unit + "^3");
print("Volume fraction occupied by BC = " + d2s(totalVolume/totalImagedVolume,2) );

selectWindow("Log");
saveAs("Text", output1+"Log.txt");  
//selectWindow("Log");
//close("Log");
roiManager("Delete");
run("Close All");
waitForUser("Done successfully!!");





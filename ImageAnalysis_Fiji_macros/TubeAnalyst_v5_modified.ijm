////////////////////////////////////////////////////////
//// Name: TubeAnalyst
//// Author: Sébastien Tosi and Christian Tischer
//// Version: 5.0
////
//// Usage: Process a 3D stack of lectin stained blood
////	    vessels acquired by a MacroSPIM to segment
////	    and analyze the blood vessel network and
////	    extract quantitative statistics. 
////////////////////////////////////////////////////////

//////////////////////////////////
// Graphical user interface (7) //
//////////////////////////////////

getPixelSize(unit, px, py, pz);
Dialog.create("TubeAnalyst");
Dialog.addNumber("Tube radius ("+unit+")", 6);
Dialog.addNumber("Vessel radius ("+unit+")", 8);
Dialog.addNumber("Vessel threshold", 8); //-1: man. calibration  
Dialog.addNumber("Minimum vessel volume (pixels)", 1000);
Dialog.addCheckbox("Remove branches with end-points", false); 
Dialog.addNumber("Dilate Skeleton for viewing by (pixels)", 2);
Dialog.addNumber("Number of threads", 8);
Dialog.addCheckbox("Save intermediate steps?", false);
Dialog.show;
ClosingRadius = Dialog.getNumber();
VesselRadius = Dialog.getNumber();  
VesselThreshold = Dialog.getNumber();
VesselVolumeThreshold = Dialog.getNumber();
PruneEnds = Dialog.getCheckbox();
VisualisationDilation = Dialog.getNumber();
Nthreads = Dialog.getNumber();
Save = Dialog.getCheckbox();

////////////////////
// Initialization //
////////////////////

run("Options...", "iterations=1 count=1 edm=Overwrite");
OriginalTitle = getTitle();

/////////////////////////////////////////////////////
// Morphological closing of tubular structures (1) //
/////////////////////////////////////////////////////

// Parameters
// ClosingRadius = 3 // units: micrometer
// Nthreads = 8 // units: count

// Work on the small image "BloodVessels_small.tif";

// Filtering: closing to fill hollow tubes
//run("3D Fast Filters","filter=CloseGray radius_x_pix="+d2s(ClosingRadius/px,2)+" radius_y_pix="+d2s(ClosingRadius/py,2)+" radius_z_pix="+d2s(ClosingRadius/pz,2)+" Nb_cpus="+d2s(Nthreads,0));
run("3D Filters", "filter=Maximum radius_x=2 radius_y=2 radius_z=2");

rename("Closed.tif"); // we add suffix ".tif" because otherwise ImageJ adds it upon saving resulting in inconsistent image names

// Store output
if(Save==true) run("Save");

/////////////////////////////////////////////////////
// Prefiltering to enhance filamentous voxels (2)  //
/////////////////////////////////////////////////////

// Work on the closed image
selectImage("Closed.tif");

// Parameters
// VesselRadius = 8 // units: micrometer

run("Tubeness", "sigma="+d2s(VesselRadius,2)+" use");
rename("Tubeness.tif");

// Store output
if(Save==true) run("Save");

// Cleanup
selectImage("Closed.tif"); close();

////////////////////////////////////////////
// Segmentation of tubular structures (3) //
////////////////////////////////////////////

// Work on the image after tubeness filtering
selectImage("Tubeness.tif");

// Parameters
// VesselThreshold = 8 // units: gray values
// VesselVolumeThreshold = 1000 // units: voxels

// Convert the 32-bit Tubeness image to 8-bit for thresholding
Stack.getStatistics(voxelCount, mean, min, max);
setMinAndMax(min,max);
run("8-bit");

// Threshold
setThreshold(VesselThreshold,255);
run("Convert to Mask", "method=Default background=Dark"); 
setSlice(nSlices/2); // move to central slices (only for nice viewing)

// Find connected components, remove too small objects and apply Random LUT
run("3D OC Options", "volume nb_of_obj._voxels dots_size=5 font_size=10 redirect_to=none"); //  to ensure that ResultsTable is named "Results", i.e. uncheck the "macro friendly" naming
run("3D Objects Counter", "threshold=128 min.="+d2s(VesselVolumeThreshold,2)+" max.="+d2s(nSlices*getWidth()*getHeight(),0)+" objects statistics summary");
run("glasbey inverted"); // run("Random") // change LUT 

rename("LabelMask.tif"); 
	
// Store output
if(Save==true) run("Save");

// Cleanup
selectWindow("Results"); run("Close"); 
selectImage("Tubeness.tif"); close();

/////////////////////////////////////////////////////
// Skeletonization/analysis of tubular network (4) //
/////////////////////////////////////////////////////

// Work on the label mask
selectImage("LabelMask.tif");

// Parameters
VisualisationDilation = 2; // units: pixels

// Make binary image
run("Duplicate...", "title=BinarizedTubes.tif duplicate"); // work on duplicate as we need the Labelmask later
run("8-bit");
setThreshold(1,255);
run("Convert to Mask", "method=Default background=Dark");

// Store output
if(Save==true) run("Save");

// Skeletonize
run("Duplicate...", "title=Skeleton duplicate"); // work on duplicate
run("Skeletonize (2D/3D)");
rename("Skeleton.tif");

// Remove end-point branches by pruning
if(PruneEnds) run("Analyze Skeleton (2D/3D)", "prune=none prune"); // no circular pruning, but end-point pruning
else run("Analyze Skeleton (2D/3D)", "prune=none"); // no circular pruning, no end-point pruning

IJ.renameResults("Results","Skeleton Results.xls"); // rename results table for preventing it from being overwritten by other "Results"

// Store output
if(Save==true) saveAs("Skeleton Results.xls");

// Beautify the visualisation:
// 1. Change analyzed skeleton colors
//run("Macro...", "code=v=(v==127)*127+(v==30)*192+(v==70)*255 stack");
// 2. Thicken analyzed skeleton
//run("3D Fast Filters","filter=Maximum radius_x_pix="+d2s(VisualisationDilation,0)+" radius_y_pix="+d2s(VisualisationDilation,0)+" radius_z_pix="+d2s(VisualisationDilation,0)+" Nb_cpus="+d2s(Nthreads,0));
// 3. Change the LUT
run("Fire");
rename("ThickSkeleton.tif"); 
	
// Store output
if(Save==true) run("Save");

// Cleanup
//selectImage("Tagged skeleton"); close();

////////////////////////////////////////////////////////
// Extraction of biologically relevant parameters (6) //
////////////////////////////////////////////////////////

// Total vessel length
IJ.renameResults("Skeleton Results.xls", "Results"); // make table accessible
totalLength = 0;
nBranches = 0;
for(i=0; i<nResults; i++) {
	totalLength = totalLength + getResult("# Branches", i)*getResult("Average Branch Length", i);
	nBranches = nBranches + getResult("# Branches", i);	
}
IJ.renameResults("Results","Skeleton Results.xls"); // prevent table from being overwritten 

// Total imaged and blood vessels volumes
selectWindow("BinarizedTubes.tif"); // image containing the segmented vessels
Stack.getStatistics(voxelCount, mean, min, max, stdDev);
//getVoxelSize(width, height, depth, unit);
totalImagedVolume = voxelCount*px*py*pz;
totalVolume = voxelCount*mean/255*px*py*pz;

// Mean vessel x-section and diameter
meanCrosssection = totalVolume / totalLength;
meanDiameter = 2*sqrt(meanCrosssection/PI);

print("");
print("");
print("Results");
print("----------");
print("Image name: "  + OriginalTitle);
print("Pruning = " + d2s(PruneEnds,0));
print("Total length = " + d2s(totalLength,2) + " " + unit);
print("Number of branches = " + d2s(nBranches,0) ); 
print("Average branch length = " + d2s(totalLength/nBranches,2) + " " + unit); 
print("Mean vessel cross-section = " + d2s(meanCrosssection,2) + " " + unit + "^2");
print("Mean vessel diameter = " + d2s(meanDiameter,2) + " " + unit);
print("Total vessel volume = " + d2s(totalVolume,2) + " " + unit + "^3" );
print("Total imaged volume = " + d2s(totalImagedVolume,2) + " " + unit + "^3");
print("Volume fraction occupied by vessels = " + d2s(totalVolume/totalImagedVolume,2) );

///////////////////////////////////
// 3-D results visualisation (8) //
///////////////////////////////////

// Merge original stack and skeleton 
selectImage("Skeleton.tif");
run("Invert LUT");
run("Merge Channels...", "c1=*None* c2=Skeleton.tif c3="+OriginalTitle+" create keep");

// Load original stack, label mask and analyzed skeleton in 3D viewer
run("3D Viewer");
call("ij3d.ImageJ3DViewer.setCoordinateSystem", "false");
call("ij3d.ImageJ3DViewer.add", OriginalTitle, "None", OriginalTitle, "0", "true", "true", "true", "2", "0");
call("ij3d.ImageJ3DViewer.add", "LabelMask.tif", "None", "LabelMask.tif", "0", "true", "true", "true", "2", "0");
call("ij3d.ImageJ3DViewer.add", "ThickSkeleton.tif", "None", "ThickSkeleton.tif", "0", "true", "true", "true", "2", "0");
call("ij3d.ImageJ3DViewer.startAnimate");
//This program helps to count parasite 


filepath=File.openDialog("Select input image"); 
image= File.getName(filepath);
filepath_new=File.openDialog("Select input image: PVM mask");
image_PVM_mask=File.getName(filepath_new);
output = getDirectory("Choose output directory");
file=File.makeDirectory(output+image+"_parasitecount_result");
output1 = output+image+"_parasitecount_result/";
print (output1);


open(filepath_new);
open(filepath);
selectWindow(image);
run("Duplicate...", "title=dupli_image duplicate");
run("Split Channels");
selectWindow(image);
close();
selectWindow("C4-dupli_image"); //$ DAPI channel


run("Duplicate...", "title=DAPI.tif duplicate");
run("Median 3D...", "x=1.5 y=1.5 z=1.5");
run("Threshold...");
wait(1000); 
setAutoThreshold("Default dark");
waitForUser("Threshold", "Please adjust threshold and then click OK"); 
run("Convert to Mask", "stack");
run("Dilate", "stack");
//run("Dilate", "stack");
run("Erode", "stack");
run("Fill Holes", "stack");
saveAs("Tiff", output1+ "DAPI.tif");

selectWindow(image_PVM_mask);
selectWindow("PVM.labels.avi");
saveAs("Tiff", output1+ "PVM_mask.tif");
selectWindow("PVM_mask.tif");
run("Threshold...");
wait(1000); 
setAutoThreshold("Default dark");
waitForUser("Threshold", "Please adjust threshold and then click OK"); 
//run("Convert to Mask", "stack");
run("Analyze Particles...", "clear add stack");

w=getWidth(); 
h=getHeight(); 
s=nSlices(); 
print (s);
newImage("Mask", "8-bit Black", w, h, s); 
setForegroundColor(255, 255, 255); 
nb=roiManager("count"); 
for(i=0;i<nb;i++) { 
        roiManager("Select",i); 
run("Fill", "slice"); 
} 

imageCalculator("Multiply create stack", "DAPI.tif","Mask");
selectWindow("Result of DAPI.tif");



run("3D Manager");
Ext.Manager3D_Segment(128, 255);

Ext.Manager3D_AddImage();
Ext.Manager3D_Measure();
Ext.Manager3D_SaveResult("M", output1+ "Results3D.csv");
run("Random");
saveAs("Tiff", output1+ "3Dseg.tif");
close("3D Manager");

roiManager("Select All");
roiManager("Delete");
run("Close");

waitForUser("Done successfully!!");
run("Close All");


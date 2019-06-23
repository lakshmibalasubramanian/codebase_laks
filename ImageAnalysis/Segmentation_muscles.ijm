// This script is to segment the muscles regions from the image. The segmentation is semi-automated based on the imageJ plugin segmentation editor.
//The segmentation is done for all the 12 segments (aR(1),aL(2),bR(3),bL(4),cR(5),cL(6),dR(7),dL(8),eR(9),eL(10),fR(11),fL(12)) in a for loop
//Input: The input image will the stack image of the muscles.
//Output: There will be 12 masks tif files, 12 csv files, 12 object files.

//******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************


//Open the image containing folder and creates the output folder. This is based on the user selection
filepath=File.openDialog("Select input image"); 
image= File.getName(filepath);
output = getDirectory("Choose output directory");
file=File.makeDirectory(output+image+"_result");
output1 = output+image+"_result/";


for (i = 0; i < 12; i++) {
	n=i+1;
	open(filepath);
	selectWindow(image);
	run("Duplicate...", "title=stack_dupli.tif duplicate");
	//close(image);
	selectWindow("stack_dupli.tif");
	run("8-bit");
	setTool("freehand");
	Dialog.create("Segmentation Editor: Steps to be followed");
	Dialog.addMessage("(1)Uncheck 3D option\\n(2)Using freehand tool to draw the region\n(3)Click the T option for thresholding\n(4) Use O and C if required to smooth the boundery\n(5)Segment the muscles manually from few random slices\n(6)Click 'I'\n(7)Check 3D\n(8)Click '+'\n(6)Finally click OK");
	Dialog.show();
	//waitForUser("Segmentation Editor: Segmentation of muscles in the Editor", "(1)Uncheck 3D option(2)Right click on the label interior to rename and change the color(3)Create the 12 labels with different color and labels (4)Segment PVM manually from few random slices (3)Click 'I' (4)Check 3D (5)Click '+' (6)Finally click OK"); 
	run("Segmentation Editor", "name=A min=101 max=255 erode/dilate=0 slice=1 min=104 max=255 erode/dilate=0 slice=19 min=103 max=255 erode/dilate=0 slice=50");
	//run("Segmentation Editor");
	//wait(1000);
	selectWindow("stack_dupli.labels");
	 
	saveAs("Tiff", output1+n+"stack_dupli_labels.tif");
	selectWindow(n+"stack_dupli_labels.tif");
	//run("8-bit");
	run("3D Objects Counter", "threshold=1 slice=25 min.=10 max.=12100000 objects surfaces centroids centres_of_masses statistics summary");
	selectWindow("Objects map of "+n+"stack_dupli_labels.tif");
	saveAs("Tiff", output1+n+"Objects map of "+n+"stack_dupli_labels.tif");
	
	selectWindow("Statistics for "+n+"stack_dupli_labels.tif");
	//saveAs("Results", "/Users/lakshmibalasubramanian/Documents/Lakshmi/Dhananjay_KVR/set2maleday2-6DS/output_try/main.csv");
	saveAs("Results", output1+n+"Statistics for "+n+"stack_dupli_labels.csv");
	//close("Objects map of "+n+"stack_dupli_labels.tif");
	//close("Surface map of "+n+"stack_dupli_labels.tif");
	//close("Centroids map of "+n+"stack_dupli_labels.tif");
	//close("Centres of mass map of "+n+"stack_dupli_labels.tif");
	run("Close All");

	
}
print("\\Clear");



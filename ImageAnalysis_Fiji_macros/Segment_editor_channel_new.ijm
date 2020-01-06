//Program description: This macro does the bile canaliculi (BC) thersholding and segments the PVM, infected cell & five uninfected cells. The surface area of BC on PVM, infected cell & uninfected cells are being calculated.
//Other parameters like volume, area of segmented objects are also being calculated. 
//Segmentation of PVM, infected & uninfected cells (5) are being carried manually. So the macro is interactive for the segmentation.
//INPUT: Z-stack images with four channels (One image at a time); OUTPUT: 14 .csv files & 15 .avi files are generated for one image
//TIPS: Before choosing the input image user should check the channel numbers for the four channels. The channel number could be changed according to the choosen image in the lines with "$" symbol where the channel number is specified.

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Open the image containing folder and creates the output folder. This is based on the user selection
filepath=File.openDialog("Select input image"); 
image= File.getName(filepath);
output = getDirectory("Choose output directory");
//out_dir = image+"_result";
file=File.makeDirectory(output+image+"_result");
output1 = output+image+"_result\\";

//Open the image and do the preliminary steps like duplicating, splitting channels, smoothing etc..Also close the unwanted channels
open(filepath);
selectWindow(image);
run("Duplicate...", "title=dupli_image duplicate");
run("Split Channels");
selectWindow("C4-dupli_image"); //$ DAPI channel
close();
selectWindow(image);
close();

//Choose CD13 channel (BC). Thersholding and other processes
selectWindow("C3-dupli_image"); //$ CD13 channel
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
run("AVI... ", "compression=JPEG frame=10 save="+output1+"C3-dupli_image.avi"); //$ CD13 channel


//Segmentation of PVM using segmentation editor; Saving the obtained results file (volume of the PVM, Surface area of bile canaliculi on PVM) as .csv 
//in the output folder
selectWindow("C1-dupli_image"); //$ UIS4 channel
run("Red");
run("Smooth", "stack");
run("Smooth", "stack");
setTool("freehand");
waitForUser("Segmentation Editor: Segment the PVM", "(1)Uncheck 3D option (2)Segment PVM manually from few random slices (3)Click 'I' (4)Check 3D (5)Click '+' (6)Finally click OK"); 
run("Segmentation Editor");
wait(1000);
selectWindow("C1-dupli_image.labels");
rename("PVM.labels");
run("AVI... ", "compression=JPEG frame=10 save="+output1+"PVM.labels.avi");
run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
selectWindow("Statistics for PVM.labels");
saveAs("Results", output1+"statistics_PVM.csv"); 
selectWindow("PVM.labels");
imageCalculator("Subtract create stack", "PVM.labels","C3-dupli_image"); //$ CD13 channel
selectWindow("Result of PVM.labels");
rename("Result of PVM.labels1");
close("Result of PVM.labels");
imageCalculator("Subtract create stack", "PVM.labels","Result of PVM.labels1");
selectWindow("Result of PVM.labels");
rename("PVM_BC_surface");
run("AVI... ", "compression=JPEG frame=10 save="+output1+"PVM_BC_surface.avi");
close("Result of PVM.labels");
selectWindow("PVM_BC_surface");
run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
selectWindow("Statistics for PVM_BC_surface");
saveAs("Results",output1+"statistics_PVM_surfacearea_BC.csv");
close("C1-dupli_image"); //$ UIS4 channel
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



//Segmentation of infected cell using segmentation editor; Saving the obtained results file (volume of the cell, Surface area of bile canaliculi) as .csv in the output folder
selectWindow("C2-dupli_image"); //$ Phalloidin channel
setTool("freehand");
waitForUser("Segmentation Editor: Segment infected cell", "(1)Uncheck 3D option (2)Segment infected cell manually from few random slices (3)Click 'I' (4)Check 3D (5)Click '+' (6)Finally click OK"); 
run("Segmentation Editor");
wait(1000);
selectWindow("C2-dupli_image.labels"); //$ Phalloidin channel
rename("Infected_cell.labels");
run("AVI... ", "compression=JPEG frame=10 save="+output1+"Infected_cell.labels.avi");
run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
selectWindow("Statistics for Infected_cell.labels");
saveAs("Results", output1+"statistics_inf_cell.csv"); 
selectWindow("Infected_cell.labels");
imageCalculator("Subtract create stack", "Infected_cell.labels","C3-dupli_image"); //$ CD13 channel
selectWindow("Result of Infected_cell.labels");
rename("Result of Infected_cell.labels1");
close("Result of Infected_cell.labels");
imageCalculator("Subtract create stack", "Infected_cell.labels","Result of Infected_cell.labels1");
selectWindow("Result of Infected_cell.labels");
rename("Infec_Cells_BC_surface");
run("AVI... ", "compression=JPEG frame=10 save="+output1+"Infec_Cells_BC_surface.avi");
close("Result of Infected_cell.labels");
selectWindow("Infec_Cells_BC_surface");
run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
selectWindow("Statistics for Infec_Cells_BC_surface");
saveAs("Results",output1+"statistics_inf_surfacearea_BC.csv");
close("Infected_cell.labels");
close("Objects map of Infected_cell.labels");
close("Surface map of Infected_cell.labels");
close("Centroids map of Infected_cell.labels");
close("Centres of mass map of Infected_cell.labels");
close("Infec_Cells_BC_surface");
close("Objects map of Infec_Cells_BC_surface");
close("Surface map of Infec_Cells_BC_surface");
close("Centroids map of Infec_Cells_BC_surface");
close("Centres of mass map of Infec_Cells_BC_surface");



//Segmentation of uninfected cells (5) using segmentation editor; Saving the obtained results file (volume of the cell, Surface area of bile canaliculi) as .csv 
//in the output folder
//This loop will prompt the user to segment 5 uninfected cell

for(i=0;i<5;i++)
{   
	n=i+1;
	selectWindow("C2-dupli_image"); //$ Phalloidin channel
	setTool("freehand");
	waitForUser("Segmentation editor:Segment uninf cell"+n, "(1)Uncheck 3D option (2)Segment cell of interest manually from few random slices (3)Click 'I' (4)Check 3D (5)Click '+' (6)Finally click OK"); 
	run("Segmentation Editor");
	wait(1000);
	selectWindow("C2-dupli_image.labels"); //$ Phalloidin channel
	rename(n+"Uninfected_cell.labels");
	run("AVI... ", "compression=JPEG frame=10 save="+output1+n+"Uninfected_cell.labels.avi");
	run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
	name = ""+n+"Uninfected_cell.labels";
	selectWindow("Statistics for "+name);
	saveAs("Results", output1+n+"statistics_uninf_cell.csv"); 
	selectWindow(n+"Uninfected_cell.labels");
	imageCalculator("Subtract create stack", ""+n+"Uninfected_cell.labels","C3-dupli_image"); //$ CD13 channel
	selectWindow("Result of "+name);
	rename("Result of "+name+"1");
	close("Result of "+name);
	imageCalculator("Subtract create stack", ""+n+"Uninfected_cell.labels","Result of "+name+"1");
	selectWindow("Result of "+name);
	rename(n+"Uninf_Cells_BC_surface");
	run("AVI... ", "compression=JPEG frame=10 save="+output1+n+"Uninf_Cells_BC_surface.avi");
	close("Result of C2-dupli_image.labels"); //$ Phalloidin channel
	selectWindow(n+"Uninf_Cells_BC_surface");
	run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
	name_new = ""+n+"Uninf_Cells_BC_surface";
	selectWindow("Statistics for "+name_new);
	saveAs("Results",output1+n+"statistics_uninf_surfacearea_BC.csv");
	close(n+"Uninfected_cell.labels");
	close("Objects map of "+n+"Uninfected_cell.labels");
	close("Surface map of "+n+"Uninfected_cell.labels");
	close("Centroids map of "+n+"Uninfected_cell.labels");
	close("Centres of mass map of "+n+"Uninfected_cell.labels");
	close(n+"Uninf_Cells_BC_surface");
	close("Objects map of "+n+"Uninf_Cells_BC_surface");
	close("Surface map of "+n+"Uninf_Cells_BC_surface");
	close("Centroids map of "+n+"Uninf_Cells_BC_surface");
	close("Centres of mass map of "+n+"Uninf_Cells_BC_surface");
} 

waitForUser("Done successfully!!");
close("*");

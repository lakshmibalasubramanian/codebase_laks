//This macro is same i.e to calculate volume, SA of BC but this is without the cell segmentation.
//Here the input is the segmented inf & uninf cell mask & thersholded CD13 channel. Using the cell mask it is expanded to the desired pixels & calculate the above 
//INPUTs(3): Inf & uninfec cell mask & thersholded BC : C1-dupli_image.tif, 1Uninfected_cell_mask.tif, Infected_cell_mask.tif

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//Program description: This macro does the 1. bile canaliculi (BC) thersholding 
//2. segments infected cell & one uninfected cell (this number of uninfec cells can be increased in the for loop).
//3. Calculates surface area of BC on infected & uninfected cells 
//4. Expands the cells (both infec & uninfec) by n pixels & calculates the surface area
//Calculates parameters like volume, surface area of BC
//Segmentation of infected & uninfected cells are being carried manually. So the macro is interactive for the segmentation.
//INPUT: Z-stack images with four channels (One image at a time)
//OUTPUT: 
//TIPS: Before choosing the input image user should check the channel numbers for the four channels. The channel number could be changed according to the choosen image in the lines with "$" symbol where the channel number is specified.

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Choose the image. Choose the folder for output.
//filepath=File.openDialog("Select input image"); 
//image= File.getName(filepath);
output1 = getDirectory("Choose output directory");
//out_dir = image+"_result";
//file=File.makeDirectory(output+image+"_result");
//output1 = output+image+"_result\\";



//Infected cell: Segmentation of infected cell using segmentation editor; Saving the obtained results file (volume of the cell, Surface area of bile canaliculi) as .csv in the output folder
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
//Running 3D object counter for the segmented mask in order to calculate Volume
selectWindow("Infected_cell_mask.tif");
run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
saveAs("Results", output1+"statistics_inf_cell.csv"); 


//Getting the mask of the surface area of BC on the infected cell using image calculator
//selectWindow("Infected_cell.labels");
selectWindow("Infected_cell_mask.tif");
imageCalculator("Subtract create stack", "Infected_cell_mask.tif","C1-dupli_image.tif"); //$ CD13 channel  //Subtracting the infec cell mask from the thersholded BC
selectWindow("Result of Infected_cell_mask.tif");
rename("Result of Infected_cell_mask.tif1");
close("Result of Infected_cell_mask.tif");
imageCalculator("Subtract create stack", "Infected_cell_mask.tif","Result of Infected_cell_mask.tif1"); //The resulted subtracted mask is again subtracted from the initial mask
selectWindow("Result of Infected_cell_mask.tif");
rename("Infec_Cells_BC_surface");
run("Duplicate...", "title=Infec_cell_BC_surface_mask.tif duplicate");
saveAs("Tiff",output1+"Infec_cell_BC_surface_mask.tif");
//close("Result of Infected_cell_mask.tif");

//Running 3D object counter for the surface mask of BC in order to calculate surface area. From the results we consider the surface voxels
selectWindow("Infec_Cells_BC_surface");
run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
saveAs("Results",output1+"statistics_inf_surfacearea_BC.csv");


//Closing all the resultant window of the 3D object counter
close("Objects map of Infected_cell.labels");
close("Surface map of Infected_cell.labels");
close("Centroids map of Infected_cell.labels");
close("Centres of mass map of Infected_cell.labels");
close("Infec_Cells_BC_surface");
close("Objects 2map of Infec_Cells_BC_surface");
close("Surface map of Infec_Cells_BC_surface");
close("Centroids map of Infec_Cells_BC_surface");
close("Centres of mass map of Infec_Cells_BC_surface");
*/

//This part of the macro is to expand/enlarge the infected cell mask by n pixels (~5 currently) & using this expanded mask calculates the surface area of BC on infected cell
//1. Consider the infec cell mask. 2. Convert it into binary 3. Thershold & segment the mask in all the slices & add it to ROI manager
//4. Expand the segmented objects by 5 pixels in all the slices (done using the for the loop)
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 //Thresholding the infec cell mask in all the slices
//selectWindow("Infected_cell.labels");
selectWindow("Infected_cell_mask.tif");
run("8-bit");
run("Threshold...");
wait(1000); 
setAutoThreshold("Default dark");
waitForUser("Threshold", "Please adjust threshold and then click OK"); 
run("Convert to Mask", "stack");
run("Make Binary", "method=Default background=Dark calculate");
run("Invert", "stack");
run("Analyze Particles...", "size=20-Infinity show=Masks add stack");   
count_obj = roiManager("count");      //counting the objects in the ROI manager

for (ctr=0;ctr<count_obj;ctr++)
	{
		roiManager("Select",ctr);
		run("Enlarge...", "enlarge=3");    //Expanding the mask by 5 pixels
		run("Fill", "slice");
	}
roiManager("Show All without labels");
roiManager("Show None");
//selectWindow("Infected_cell.labels");
selectWindow("Infected_cell_mask.tif");
close();
roiManager("Delete");

//Saving the expanded mask after removing all the selections
//selectWindow("Mask of Infected_cell.labels");
selectWindow("Mask of Infected_cell_mask.tif");
rename("Infec_cell_mask_expand_3.tif");
roiManager("Show All without labels");
roiManager("Show None");
saveAs("Tiff", output1+"Infec_cell_mask_expand_3.tif");
selectWindow("Infec_cell_mask_expand_3.tif");
run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
saveAs("Results",output1+"statistics_inf_cell_expanded_3.csv");
selectWindow("Infec_cell_mask_expand_3.tif");


//Getting the mask of the surface area of BC on the expand infected cell using image calculator (same as earlier steps but this is just with the expanded mask
imageCalculator("Subtract create stack", "Infec_cell_mask_expand_3.tif","C1-dupli_image.tif"); //$ CD13 channel
selectWindow("Result of Infec_cell_mask_expand_3.tif");
rename("Result of Infec_cell_mask_expand_3.tif1");
imageCalculator("Subtract create stack", "Infec_cell_mask_expand_3.tif","Result of Infec_cell_mask_expand_3.tif1");
selectWindow("Result of Infec_cell_mask_expand_3.tif");
rename("Infec_Cells_BC_surface_expand_3");
saveAs("Tiff", output1+"Infec_Cells_BC_surface_expand_3.tif");
run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
saveAs("Results",output1+"statistics_inf_surfacearea_BC_expand_3.csv");
close("Objects map of Infec_Cells_BC_surface_expand_3.tif");
close("Surface map of Infec_Cells_BC_surface_expand_3.tif");
close("Centroids map of Infec_Cells_BC_surface_expand_3.tif");
close("Centres of mass map of Infec_Cells_BC_surface_expand_3.tif");
roiManager("Show All without labels");
roiManager("Show None");
close("Infected_cell_mask.tif");
roiManager("Delete");
close("Result of Infected_cell_mask.tif1");
close("Result of Infec_cell_mask_expand_3.tif1");
close("Infected_cell_mask.tif");
close("Infec_cell_BC_surface_mask.tif");
close("Infec_cells_BC_surface_expand_3.tif");
close("Infec_cell_mask_expand_3.tif");
close("Results");
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



//Uninfected cells (5): Segmentation using segmentation editor; Saving the obtained results file (volume of the cell, Surface area of bile canaliculi) as .csv 
//in the output folder
//This loop will prompt the user to segment 5 uninfected cell
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


//Segmentation using segmentation editor
for(i=0;i<1;i++)
{   
	n=i+1;
/*	
    ///Running 3D object counter for the segmented mask in order to calculate Volume	
	selectWindow(n+"Uninfected_cell_mask.tif");
	run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
	name = ""+n+"Uninfected_cell_mask.tif";
	saveAs("Results", output1+n+"statistics_uninf_cell.csv"); 

	//Getting the mask of the surface area of BC on the infected cell using image calculator
	selectWindow(n+"Uninfected_cell_mask.tif");
	imageCalculator("Subtract create stack", ""+n+"Uninfected_cell_mask.tif","C1-dupli_image.tif"); //$ CD13 channel
	selectWindow("Result of "+name);
	rename("Result of "+name+"1");
	close("Result of "+name);
	imageCalculator("Subtract create stack", ""+n+"Uninfected_cell_mask.tif","Result of "+name+"1");
	selectWindow("Result of "+name);
	rename(n+"Uninf_Cells_BC_surface");
	run("Duplicate...", "title=Infec_cell_BC_surface_mask.tif duplicate");
	saveAs("Tiff", output1+n+"Uninfec_cell_BC_surface_mask.tif");
	close("Result of C1-dupli_image.labels"); //$ Phalloidin channel
	
	//Running 3D object counter for the surface mask of BC in order to calculate surface area. From the results we consider the surface voxels
	selectWindow(n+"Uninf_Cells_BC_surface");
	run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
	name_new = ""+n+"Uninf_Cells_BC_surface";
	saveAs("Results",output1+n+"statistics_uninf_surfacearea_BC.csv");
	
	//Closing all the resultant window of the 3D object counter
	close("Objects map of "+n+"UUninfected_cell_mask.tif");
	close("Surface map of "+n+"Uninfected_cell_mask.tif");
	close("Centroids map of "+n+"Uninfected_cell_mask.tif");
	close("Centres of mass map of "+n+"Uninfected_cell_mask.tifs");
	close(n+"Uninf_Cells_BC_surface");
	close("Objects map of "+n+"Uninf_Cells_BC_surface");
	close("Surface map of "+n+"Uninf_Cells_BC_surface");
	close("Centroids map of "+n+"Uninf_Cells_BC_surface");
	close("Centres of mass map of "+n+"Uninf_Cells_BC_surface");
*/
	//This part of the macro is to expand/enlarge the uninfected cell mask by n pixels (~5 currently) & using this expanded mask calculates the surface area of BC on infected cell
	//1. Consider the infec cell mask. 2. Convert it into binary 3. Thershold & segment the mask in all the slices & add it to ROI manager
	//4. Expand the segmented objects by 5 pixels in all the slices (done using the for the loop)
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	//Thresholding the uninfec cell mask in all the slices
	selectWindow(n+"Uninfected_cell_mask.tif");
	run("8-bit");
	run("Threshold...");
	wait(1000); 
	setAutoThreshold("Default dark");
	selectWindow(n+"Uninfected_cell_mask.tif");
	waitForUser("Threshold", "Please adjust threshold and then click OK"); 
	run("Convert to Mask", "stack");
	run("Make Binary", "method=Default background=Dark calculate");
	run("Invert", "stack");
	run("Analyze Particles...", "size=20-Infinity show=Masks add stack");   
	count_obj = roiManager("count");      //counting the objects in the ROI manager

	for (ctr=0;ctr<count_obj;ctr++)
		{
			roiManager("Select",ctr);
			run("Enlarge...", "enlarge=3");    //Expanding the mask by 5 pixels
			run("Fill", "slice");
		}
	roiManager("Show All without labels");
	roiManager("Show None");
	selectWindow(n+"Uninfected_cell_mask.tif");
	close();
	roiManager("Delete");

	//Saving the expanded mask after removing all the selections
	selectWindow("Mask of "+n+"Uninfected_cell_mask.tif");
	rename(n+"Uninfec_cell_mask_expand_3.tif");
	roiManager("Show All without labels");
	roiManager("Show None");
	saveAs("Tiff", output1+n+"Uninfec_cell_mask_expand_3.tif");
	selectWindow(n+"Uninfec_cell_mask_expand_3.tif");
	run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
    saveAs("Results", output1+n+"statistics_uninf_cell_expanded_3.csv"); 
	selectWindow(n+"Uninfec_cell_mask_expand_3.tif");
    
	//Getting the mask of the surface area of BC on the expand infected cell using image calculator (same as earlier steps but this is just with the expanded mask
	imageCalculator("Subtract create stack", ""+n+"Uninfec_cell_mask_expand_3.tif","C1-dupli_image.tif"); //$ CD13 channel
	selectWindow("Result of "+n+"Uninfec_cell_mask_expand_3.tif");
	rename("Result of "+n+"Uninfec_cell_mask_expand_3.tif1");
	imageCalculator("Subtract create stack", ""+n+"Uninfec_cell_mask_expand_3.tif","Result of "+n+"Uninfec_cell_mask_expand_3.tif1");
	selectWindow("Result of "+n+"Uninfec_cell_mask_expand_3.tif");
	rename(n+"Uninfec_Cells_BC_surface_expand_3");
	saveAs("Tiff", output1+n+"Uninfec_Cells_BC_surface_expand_3.tif");
	run("3D Objects Counter", "threshold=1 slice=26 min.=100 max.=55574528 objects surfaces centroids centres_of_masses statistics summary");
	saveAs("Results",output1+n+"statistics_uninf_surfacearea_BC_expand_3.csv");
	close("Objects map of "+n+"Uninfec_Cells_BC_surface_expand_3.tif");
	close("Surface map of "+n+"Uninfec_Cells_BC_surface_expand_3.tif");
	close("Centroids map of "+n+"Uninfec_Cells_BC_surface_expand_3.tif");
	close("Centres of mass map of "+n+"Uninfec_Cells_BC_surface_expand_3.tif");
	roiManager("Delete");

} 


waitForUser("Done successfully!!");
close("*");

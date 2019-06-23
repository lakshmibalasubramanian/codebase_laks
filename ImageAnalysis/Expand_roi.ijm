selectWindow("Infected_cell_mask_8bit.tif");
run("Duplicate...", "title=dupli_Infected_cell_mask_8bit.tif duplicate");
run("Make Binary", "method=Default background=Dark calculate");
run("Analyze Particles...", "  show=Outlines display exclude add in_situ stack");
count_obj = roiManager("count");

for (ctr=0;ctr<count_obj;ctr++)
	{
		roiManager("Select",ctr);
		run("Enlarge...", "enlarge=5");
		run("Fill", "slice");
	}
roiManager("Show All without labels");
roiManager("Show None");
roiManager("Delete");

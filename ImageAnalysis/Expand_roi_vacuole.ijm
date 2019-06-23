selectWindow("dist_25hpi_A_2.tif_9_MCiters_200_flowIters_0.5_b0_5_b1_15_b2.tif");
run("Duplicate...", "title=dupli.tif duplicate");
run("8-bit");
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

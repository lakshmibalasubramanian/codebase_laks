//This macro was to binarise the parasite vacuole that is segmented by Tabish flow based method. For the segmented parasite I have computed the Volume using 3D objectcounter.
//In this macro will do the batch process for the specified folder i.e. input & output. A function has been generated to do the operations. This could be useful in later scripts as well

input = "/Volumes/LAKSHMI2/Lakshmi_working_data_new/Dataset_To_tabish_FlowMethod/tabish_results/48v/";
output = "/Volumes/LAKSHMI2/Lakshmi_working_data_new/Dataset_To_tabish_FlowMethod/tabish_results/48v_output/";

print(output);
setBatchMode(true);
list = getFileList(input);

for (i=0; i<list.length; i++){
	
	vacuolesegmentation(input,output,list[i]);
}
setBatchMode(false);


function vacuolesegmentation(input,output,filename) {
	print(filename);
	open(input + filename);
	run("Duplicate...", "duplicate");
	run("8-bit");
	run("Threshold...");
	setThreshold(1, 255);
	setOption("BlackBackground", true);
	run("Make Binary", "method=Default background=Dark calculate");
	run("3D Objects Counter", "threshold=128 slice=64 min.=1000 max.=10699776 objects surfaces centroids centres_of_masses statistics summary");

	saveAs("Results",output+filename+"_Results.csv");
	run("Close All");	

}









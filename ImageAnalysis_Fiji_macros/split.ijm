//This macro is to split the channels and save them seperately;This is a batch process.
//User has to choose the input folder with the list of images to be split. Also choose the output folder to save the images.
 
setBatchMode(true);
dir=getDirectory("Choose an Input Directory"); 
print(dir); 
list = getFileList(dir); 
saveloc = getDirectory("Choose Ouput Directory");

for (i=0; i<list.length; i++){
	open(dir+list[i]);
	imgName=getTitle();
	run("Split Channels");
	selectWindow("C1-"+imgName);
	saveAs("Tiff", saveloc + "C1-"+imgName);
	close();
	selectWindow("C2-"+imgName);
	saveAs("Tiff", saveloc + "C2-"+imgName);
	close();
	selectWindow("C3-"+imgName);
	saveAs("Tiff", saveloc + "C3-"+imgName);
	close();
	run("Close All");
}


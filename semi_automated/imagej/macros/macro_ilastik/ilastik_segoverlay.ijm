// This imagej macro overlay an ilastik simple segmentation to the original file

// run the following command in the terminal
// ImageJ-win64.exe --headless --console -macro ilastik_overlay.ijm "imagepath overlaypath"

args = split(getArgument(),";");
image = args[0];
overlay = args[1];

imagename =  File.getName(image);
dotIndex = indexOf(imagename, ".");
imagename = substring(imagename, 0, dotIndex);
dir_overlay = File.getParent(overlay);

open(image);

open(overlay);

selectImage(2);
name = getTitle();

selectImage(1);

run("Add Image...", "image=[" + name + "] x=0 y=0 opacity=40");

run("Flatten");

run("Scale...", "x=0.15 y=0.15 interpolation=Bilinear average create title=[scaled]");

selectImage(4);

filename = imagename + "_segmentation_overlay.tiff";
print('######\n\nSaving \'' + filename + '\'\n\nin \'' + dir_overlay + '\'\n\n######\n');

outFile = dir_overlay + '/' + filename
saveFile(outFile);

run("Close All");


function saveFile(outFile) {
	 saveAs("Tiff", outFile);
   //run("Bio-Formats Exporter", "save=[" + outFile + "] compression=Uncompressed");
}
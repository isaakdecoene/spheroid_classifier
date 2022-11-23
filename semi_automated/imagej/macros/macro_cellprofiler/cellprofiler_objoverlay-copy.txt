// This imagej macro overlay an cell profiler object output to the original file

// run the following command in the terminal
// ImageJ-win64.exe --headless --console -macro ilastik_overlay.ijm "imagepath overlaypath"

args = split(getArgument(),";");
image = args[0];
overlay = args[1];

overlayname =  File.getName(overlay);
dotIndex = indexOf(overlayname, ".");
overlayname = substring(overlayname, 0, dotIndex);
dir_overlay = File.getParent(overlay);

open(image);

open(overlay);

run("Images to Stack", "name=Stack title=[]");

run("Z Project...", "projection=[Max Intensity]");

selectImage(2);

filename = overlayname + "_overlay.tif";
print('######\n\nSaving \'' + filename + '\'\n\nin \'' + dir_overlay + '\'\n\n######\n');

outFile = dir_overlay + '/' + filename

saveFile(outFile);

run("Close All");

function saveFile(outFile) {
	 saveAs("Tiff", outFile);
   //run("Bio-Formats Exporter", "save=[" + outFile + "] compression=Uncompressed");
}

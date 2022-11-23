// This macro converts probability.h5 file to multiple .tiff files

args = split(getArgument(),";");
probab = args[0];

probabname =  File.getName(probab);
dotIndex = indexOf(probabname, ".");
probabname = substring(probabname, 0, dotIndex);

dir_probab = File.getParent(probab);

run("Import HDF5", "select=[" + probab + "] datasetname=[/exported_data: (4474, 4506, 1) float32] axisorder=yxz applylut");

getDimensions(width, height, channels, slices, frames);

run("Stack to Images");
for (n=0; n<nImages(); n++) {
    selectImage(n+1);
    id = getImageID();
    name = getTitle();
    filename = probabname + '_ch' + name + '.tif';
    print('######\n\nSaving ' + filename + '\n\n######\n');
    outFile = dir_probab + '/' + filename;
    saveFile(outFile);
}

function saveFile(outFile) {
	 saveAs("Tif", outFile);
   //run("Bio-Formats Exporter", "save=[" + outFile + "] compression=Uncompressed");
}
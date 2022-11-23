// This macro converts segmentation.h5 file to a .tiff file

args = split(getArgument(),";");
segment = args[0];

segmentname =  File.getName(segment);
dotIndex = indexOf(segmentname, ".");
segmentname = substring(segmentname, 0, dotIndex);

dir_segment = File.getParent(segment);

run("Import HDF5", "select=[" + segment + "] datasetname=[/exported_data: (4474, 4506, 1) float32] axisorder=yxz applylut");

filename = segmentname + ".tiff";
print('######\n\nSaving \'' + filename + '\'\n\nin \'' + dir_segment + '\'\n\n######\n');

outFile = dir_segment + '/' + filename
saveFile(outFile);

run("Close All");

function saveFile(outFile) {
	 saveAs("Tiff", outFile);
   //run("Bio-Formats Exporter", "save=[" + outFile + "] compression=Uncompressed");
}
/*  
    cfZip, Allows you to create a zip archive to add files and download all zipped
*/
component {
	variables.fileName = "";
	variables.files = [];

	public function init(required string fileName) {
		variables.fileName = arguments.fileName & ".zip";
		return this;
	}

	public boolean function addFile(required string filePath) {
		if(FileExists(filePath)) {
			var bytes = FileReadBinary(arguments.filePath);
			var fileName = GetFileFromPath(arguments.filePath);
			return this.addBinary(fileName, bytes);
		}
		else {
			return false;
		}
	}

	public boolean function addBinary(required string fileName, required binary bytes) {
		if(Len(arguments.fileName) gt 0) {
			ArrayAppend(variables.files, { fileName = arguments.fileName, bytes = arguments.bytes });
			return true;
		}
		else {
			return false;
		}
	}

	public void function download() {
		response = getPageContext().getFusionContext().getResponse();
		response.setHeader("Content-Type", "application/zip");
		response.setHeader("Content-Disposition","attachment;filename=#variables.fileName#");
		response.getOutputStream().writeThrough(createBinaryZip());
		abort;
	}

	private binary function createBinaryZip() {
		var objOutputStream = createObject("java","java.io.ByteArrayOutputStream").init();
		var zipOutputStream = createObject("java","java.util.zip.ZipOutputStream").init(objOutputStream);

		for (i = 1; i lte ArrayLen(variables.files); i++) {
			var zipEntry = createObject("java","java.util.zip.ZipEntry").Init(variables.files[i].fileName);
			zipOutputStream.PutNextEntry(zipEntry);
			zipOutputStream.Write(variables.files[i].bytes, javaCast("int",0), javaCast("int", arrayLen(variables.files[i].bytes)));
			zipOutputStream.CloseEntry();
		}

		zipOutputStream.Close();
		return objOutputStream.ToByteArray();
	}
}

<cfscript>
	files = ["document-01.docx",
		"document-02.docx",
		"image-01.jpg",
		"image-02.jpeg",
		"image-03.jpg"];

	zipArchive = new cfc.cfZip("cfcZipDemo");

	for (i = 1; i lte ArrayLen(files); i++) {
		filePath = ExpandPath(".") & "\documents\" & files[i];
		zipArchive.addFile(filePath);
	}

	myImage = ImageNew("", 800, 600);
	ImageSetDrawingColor(myImage, "green");

	attr = StructNew();
	attr.underline = "yes";
	attr.size = 25;
	attr.style = "bold";

	ImageDrawText(myImage,"It's not easy being green.", 100, 150, attr);

	zipArchive.addBinary("image-at-memory.jpg", ToBinary(ToBase64(myImage)));

	zipArchive.download();
</cfscript>
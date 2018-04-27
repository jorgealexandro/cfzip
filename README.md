# CFZIP

Compress on the fly files and binaries into a zip and download from memory

```cfscript

// Create component
zipArchive = new cfc.cfZip("cfcZipDemo");

// Add file from path
filePath = ExpandPath(".") & "\documents\image.jpg";
zipArchive.addFile(filePath);

// Add binary from memory
myImage = ImageNew("", 800, 600);
zipArchive.addBinary("image-at-memory.jpg", ToBinary(ToBase64(myImage)));

// Download to browser
zipArchive.download();

```

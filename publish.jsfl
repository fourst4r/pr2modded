// This is script file for Adobe Animate, passed in as an argument.
// e.g. "Animate.exe publish.jsfl -AlwaysRunJSFL"

var slash = fl.scriptURI.lastIndexOf("/");
var uri = fl.scriptURI.substring(0, slash+1) + "src/pr2/pr2.xfl";

fl.publishDocument(uri);
fl.compilerErrors.save("ERRORLOG.txt", false, true); 
fl.quit();
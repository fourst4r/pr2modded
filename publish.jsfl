﻿
var slash = fl.scriptURI.lastIndexOf("/");
var uri = fl.scriptURI.substring(0, slash+1) + "src/pr2/pr2.xfl";

fl.publishDocument(uri);
// fl.compilerErrors.save("", false, true); 
fl.quit();
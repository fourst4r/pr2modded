package bundler;

import sys.io.File;

function main() {
    try {
        final swf = File.getBytes("bin/loader.swf");
        final projector = File.getBytes("bundler/flashplayer.exe");
        final fo = File.write("bin/loader.exe");
        fo.write(projector);
        fo.write(swf);
        fo.writeInt32(0xFA123456);
        fo.writeInt32(swf.length);
        fo.close();
    } catch (e) {
        trace("Failed to bundle swf: "+e);
    }
}
package skinning;

import blocks.Blocks;
import flash.geom.Point;
import flash.display.BitmapData;

@:bitmap("skinning/bb2.png") class DarkBasic2 extends BitmapData {}

final class Mod extends modding.ModBase {
    public override function enable() {
        trace("DARKSKIN");
        final dark = new DarkBasic2(30,30);
        Blocks.basic2Bitmap.copyPixels(dark, dark.rect, new Point(0,0));
    }
}
package skinning;

import fl.controls.CheckBox;
import flash.Lib;
import blocks.Blocks;
import flash.geom.Point;
import flash.display.BitmapData;
import api.Game;

@:bitmap("skinning/bb2.png") class DarkBasic2 extends BitmapData {}

final class Mod extends modding.ModBase {
    public override function enable() {
        trace("DARKSKIN");
        final dark = new DarkBasic2(30,30);
        Blocks.basic2Bitmap.copyPixels(dark, dark.rect, new Point(0,0));

        // Lib.current.stage.addChild(new CheckBox());
        Game.getStage().addChild(new CheckBox());
    }

    public override function disable() {
    }
}
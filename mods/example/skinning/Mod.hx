package skinning;

import blocks.Blocks;
import flash.geom.Point;
import flash.display.BitmapData;

@:bitmap("skinning/dark_bb2.png") class DarkBasic2 extends BitmapData {}

// @:bitmap("skinning/bb1.png") class Basic1Bitmap extends BitmapData {}
// @:bitmap("skinning/bb2.png") class Basic2Bitmap extends BitmapData {}
// @:bitmap("skinning/bb3.png") class Basic3Bitmap extends BitmapData {}
// @:bitmap("skinning/bb4.png") class Basic4Bitmap extends BitmapData {}
// @:bitmap("skinning/brick.png") class BrickBitmap extends BitmapData {}
// @:bitmap("skinning/mine.png") class MineBitmap extends BitmapData {}
// @:bitmap("skinning/item.png") class ItemBitmap extends BitmapData {}
// @:bitmap("skinning/ice.png") class IceBitmap extends BitmapData {}
// @:bitmap("skinning/finish.png") class FinishBitmap extends BitmapData {}
// @:bitmap("skinning/crumble.png") class CrumbleBitmap extends BitmapData {}
// @:bitmap("skinning/vanish.png") class VanishBitmap extends BitmapData {}
// @:bitmap("skinning/move.png") class MoveBitmap extends BitmapData {}
// @:bitmap("skinning/water.png") class WaterBitmap extends BitmapData {}
// @:bitmap("skinning/rotate_r.png") class RotateRightBitmap extends BitmapData {}
// @:bitmap("skinning/rotate_l.png") class RotateLeftBitmap extends BitmapData {}
// @:bitmap("skinning/push.png") class PushBitmap extends BitmapData {}
// @:bitmap("skinning/net.png") class SafetyNetBitmap extends BitmapData {}
// @:bitmap("skinning/item_inf.png") class InfiniteItemBitmap extends BitmapData {}
// @:bitmap("skinning/happy.png") class HappyBitmap extends BitmapData {}
// @:bitmap("skinning/sad.png") class SadBitmap extends BitmapData {}
// @:bitmap("skinning/heart.png") class HeartBitmap extends BitmapData {}
// @:bitmap("skinning/time.png") class TimeBitmap extends BitmapData {}

final class Mod extends modding.ModBase {
    public override function enable() {
        // trace("DARKSKIN");
        final dark = new DarkBasic2(30,30);
        Blocks.basic2Bitmap.copyPixels(dark, dark.rect, new Point(0,0));

        Blocks.basic2Bitmap1.copyPixels(dark, dark.rect, new Point(0,0));
        Blocks.basic2Bitmap2.copyPixels(dark, dark.rect, new Point(0,0));
        Blocks.basic2Bitmap3.copyPixels(dark, dark.rect, new Point(0,0));
        Blocks.basic2Bitmap4.copyPixels(dark, dark.rect, new Point(0,0));

        // final startBitmap = new StartBitmap(30,30);
        // Blocks.startBitmap.copyPixels(startBitmap, startBitmap.rect, new Point(0,0));
        // final basic1Bitmap = new Basic1Bitmap(30,30);
        // Blocks.basic1Bitmap.copyPixels(basic1Bitmap, basic1Bitmap.rect, new Point(0,0));
        // final basic2Bitmap = new Basic2Bitmap(30,30);
        // Blocks.basic2Bitmap.copyPixels(basic2Bitmap, basic2Bitmap.rect, new Point(0,0));
        // final basic3Bitmap = new Basic3Bitmap(30,30);
        // Blocks.basic3Bitmap.copyPixels(basic3Bitmap, basic3Bitmap.rect, new Point(0,0));
        // final basic4Bitmap = new Basic4Bitmap(30,30);
        // Blocks.basic4Bitmap.copyPixels(basic4Bitmap, basic4Bitmap.rect, new Point(0,0));
        // final brickBitmap = new BrickBitmap(30,30);
        // Blocks.brickBitmap.copyPixels(brickBitmap, brickBitmap.rect, new Point(0,0));
        // final basic2Bitmap1 = new Basic2Bitmap(30,30);
        // Blocks.basic2Bitmap1.copyPixels(basic2Bitmap1, basic2Bitmap1.rect, new Point(0,0));
        // final basic2Bitmap2 = new Basic2Bitmap(30,30);
        // Blocks.basic2Bitmap2.copyPixels(basic2Bitmap2, basic2Bitmap2.rect, new Point(0,0));
        // final basic2Bitmap3 = new Basic2Bitmap(30,30);
        // Blocks.basic2Bitmap3.copyPixels(basic2Bitmap3, basic2Bitmap3.rect, new Point(0,0));
        // final basic2Bitmap4 = new Basic2Bitmap(30,30);
        // Blocks.basic2Bitmap4.copyPixels(basic2Bitmap4, basic2Bitmap4.rect, new Point(0,0));
        // final mineBitmap = new MineBitmap(30,30);
        // Blocks.mineBitmap.copyPixels(mineBitmap, mineBitmap.rect, new Point(0,0));
        // final itemBitmap = new ItemBitmap(30,30);
        // Blocks.itemBitmap.copyPixels(itemBitmap, itemBitmap.rect, new Point(0,0));
        // final iceBitmap = new IceBitmap(30,30);
        // Blocks.iceBitmap.copyPixels(iceBitmap, iceBitmap.rect, new Point(0,0));
        // final finishBitmap = new FinishBitmap(30,30);
        // Blocks.finishBitmap.copyPixels(finishBitmap, finishBitmap.rect, new Point(0,0));
        // final crumbleBitmap = new CrumbleBitmap(30,30);
        // Blocks.crumbleBitmap.copyPixels(crumbleBitmap, crumbleBitmap.rect, new Point(0,0));
        // final vanishBitmap = new VanishBitmap(30,30);
        // Blocks.vanishBitmap.copyPixels(vanishBitmap, vanishBitmap.rect, new Point(0,0));
        // final moveBitmap = new MoveBitmap(30,30);
        // Blocks.moveBitmap.copyPixels(moveBitmap, moveBitmap.rect, new Point(0,0));
        // final waterBitmap = new WaterBitmap(30,30);
        // Blocks.waterBitmap.copyPixels(waterBitmap, waterBitmap.rect, new Point(0,0));
        // final rotateRightBitmap = new RotateRightBitmap(30,30);
        // Blocks.rotateRightBitmap.copyPixels(rotateRightBitmap, rotateRightBitmap.rect, new Point(0,0));
        // final rotateLeftBitmap = new RotateLeftBitmap(30,30);
        // Blocks.rotateLeftBitmap.copyPixels(rotateLeftBitmap, rotateLeftBitmap.rect, new Point(0,0));
        // final pushBitmap = new PushBitmap(30,30);
        // Blocks.pushBitmap.copyPixels(pushBitmap, pushBitmap.rect, new Point(0,0));
        // final safetyNetBitmap = new SafetyNetBitmap(30,30);
        // Blocks.safetyNetBitmap.copyPixels(safetyNetBitmap, safetyNetBitmap.rect, new Point(0,0));
        // final infiniteItemBitmap = new InfiniteItemBitmap(30,30);
        // Blocks.infiniteItemBitmap.copyPixels(infiniteItemBitmap, infiniteItemBitmap.rect, new Point(0,0));
        // final happyBitmap = new HappyBitmap(30,30);
        // Blocks.happyBitmap.copyPixels(happyBitmap, happyBitmap.rect, new Point(0,0));
        // final sadBitmap = new SadBitmap(30,30);
        // Blocks.sadBitmap.copyPixels(sadBitmap, sadBitmap.rect, new Point(0,0));
        // final heartBitmap = new HeartBitmap(30,30);
        // Blocks.heartBitmap.copyPixels(heartBitmap, heartBitmap.rect, new Point(0,0));
        // final timeBitmap = new TimeBitmap(30,30);
        // Blocks.timeBitmap.copyPixels(timeBitmap, timeBitmap.rect, new Point(0,0));
        // final customStatsBitmap = new CustomStatsBitmap(30,30);
        // Blocks.customStatsBitmap.copyPixels(customStatsBitmap, customStatsBitmap.rect, new Point(0,0));
        // final teleportBitmap = new TeleportBitmap(30,30);
        // Blocks.teleportBitmap.copyPixels(teleportBitmap, teleportBitmap.rect, new Point(0,0));
    }
}
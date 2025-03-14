package betterle;

import betterle.package_19.BlockButton.MyObjects;
import com.jiggmin.data.Objects;
import levelEditor.BlockObject;
import api.Game;
import flash.geom.Point;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import ui.CustomCursor;
import flash.geom.Rectangle;
import levelEditor.LevelEditor;
import Math.*;

class BetterLevelEditor extends LevelEditor {
    var _hotkeys:Map<UInt, Int>;

    public function new(?le:LevelEditor) {
        le ??= new LevelEditor(null);
        super(le.variables, le.isMod, le.reportsMode);
        _hotkeys = [];
        Game.getStage().addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
    }

    public override function remove():Dynamic {
        Game.getStage().removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        return super.remove();
    }

    function onKeyDown(e:KeyboardEvent) {
        switch (e.keyCode) {
            case Keyboard.ESCAPE:
                CustomCursor.pause();
            case Keyboard.R:
                CustomCursor.change(new SelectionCursor(this));
            default:
        }
        
        if (e.keyCode >= Keyboard.NUMBER_0 && e.keyCode <= Keyboard.NUMBER_9) {
            trace("d="+e.keyCode+",shft="+e.shiftKey);
            if (e.shiftKey && cur == blockBG) {
                registerHotkey(e.keyCode);
            } else {
                final displayCode = _hotkeys[e.keyCode];
                if (displayCode != null)
                    CustomCursor.change(untyped __new__(__global__["package_20.class_275"], displayCode));
            }
        }
    }

    function registerHotkey(key:UInt) {
        final block = getBlockAtPoint(new Point(stage.mouseX, stage.mouseY)) ?? return;
        _hotkeys.set(key, block.displayCode);
        trace('registered $key=${block.displayCode}');
    }

    public function getBlocksInRegion(region:Rectangle):Array<BlockObject> {
        final minX = round(region.topLeft.x / segSize);
        final minY = round(region.topLeft.y / segSize);
        final maxX = round(region.bottomRight.x / segSize);
        final maxY = round(region.bottomRight.y / segSize);
        final result = [];
        for (y in minY...maxY) {
            for (x in minX...maxX) {
                final block = blockBG.getBlockFromSeg(x, y);
                if (block != null)
                    result.push(block);
            }
        }
        return result;
    }

    public function removeBlocksInRegion(region:Rectangle) {
        final blocks = getBlocksInRegion(region);
        for (b in blocks)
            b.remove();
    }

    public function getBlockAtPoint(pt:Point):BlockObject {
        final pt = blockBG.globalToLocal(pt);
        return blockBG.getBlockFromPos(pt.x, pt.y);
    }

    public override function initialize():Dynamic {
        super.initialize();
        menu.blocks.addItem(new BlockButton(MyObjects.DUMMY), "Dummy", "Ye");
        return null;
    }
}
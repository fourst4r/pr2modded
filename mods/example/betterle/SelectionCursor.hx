package betterle;

import flash.events.Event;
import flash.geom.Rectangle;
import flash.events.KeyboardEvent;
import flash.display.Shape;
import flash.geom.Point;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
import levelEditor.LevelEditor;
import ui.CustomCursor;
import Math.*;

private class SelectionCursorGraphic extends Shape {
    public function new() {
        super();
        graphics.lineStyle(1);
        graphics.moveTo(15, 0);
        graphics.lineTo(15, 30);
        graphics.moveTo(0, 15);
        graphics.lineTo(30, 15);
    }
}

class SelectionCursor extends CustomCursor {
    var _le:BetterLevelEditor;
    var _shape:Shape;
    var _start:Point;
    var _end:Point;
    var _region:Rectangle;

    public function new(le:BetterLevelEditor) {
        super();
        CustomCursor.stageRef.addEventListener(Event.CUT, onCut);
        hideMouse();
        applyCursorGraphic(new SelectionCursorGraphic());
        _le = le;
        _le.cur.addChild(_shape = new Shape());
    }

    function onCut(e) {
        if (_region == null) {
            trace("region was null");
            return;
        }
        final blocks = _le.getBlocksInRegion(_region);
        for (b in blocks)
            b.remove();
        if (blocks.length > 0)
            CustomCursor.change(new ObjectGroupCursor(_le, blocks));
    }

    function drawSelectionRect() {
        final x = min(_start.x, _end.x);
        final y = min(_start.y, _end.y);
        final w = max(_start.x, _end.x) - x;
        final h = max(_start.y, _end.y) - y;
        final g = _shape.graphics;
        g.clear();
        g.lineStyle(1, Std.int(_le.bg.bgColor) ^ 0xffffff);
        g.drawRect(x, y, w, h);
    }

    public override function mouseDownHandler(e:MouseEvent):Dynamic {
        super.mouseDownHandler(e);
        
        final clickedMenu = _le.menu.hitTestPoint(e.stageX, e.stageY, true);
        if (clickedMenu) {
            return remove();
        }

        _start = _le.cur.globalToLocal(new Point(e.stageX, e.stageY));
        _end = _start;
        _region = null;
        return null;
    }

    public override function mouseMoveHandler(e:MouseEvent):Dynamic {
        super.mouseMoveHandler(e);
        
        if (!isMouseDown()) {
            return null;
        }

        final pt = _le.cur.globalToLocal(new Point(e.stageX, e.stageY));
        if (_start == null) {
            _start = pt;
        } else {
            _end = pt;
        }
        drawSelectionRect();

        return null;
    }

    public override function mouseUpHandler(e:MouseEvent):Dynamic {
        super.mouseUpHandler(e);
        _shape.graphics.clear();
        _region = new Rectangle();
        _region.x = min(_start.x, _end.x);
        _region.y = min(_start.y, _end.y);
        _region.right = max(_start.x, _end.x);
        _region.bottom = max(_start.y, _end.y);
        _start = null;
        _end = null;
        return null;
    }

    public override function keyDownHandler(e:KeyboardEvent):Dynamic {
        trace(e.keyCode+","+e.ctrlKey+",region="+_region);
        switch (e.keyCode) {
            case Keyboard.DELETE, Keyboard.Q:
                _le.removeBlocksInRegion(_region);
            default:
        }
        return null;
    }

    public override function remove():Dynamic {
        _shape.parent?.removeChild(_shape);
        return super.remove();
    }
}
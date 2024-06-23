package betterle;

import flash.geom.Point;
import flash.events.MouseEvent;
import levelEditor.BlockObject;
import flash.display.Sprite;
import com.jiggmin.data.Objects;
import levelEditor.LevelEditor;
import ui.CustomCursor;

class ObjectGroupCursor extends CustomCursor {
    var _le:LevelEditor;
    var _objects:Array<BlockObject>;
    var _group:Sprite;

    public function new(le:LevelEditor, objects:Array<BlockObject>) {
        super();
        _le = le;
        _objects = objects;
        _group = new Sprite();

        final offsetX = objects[0].x;
        final offsetY = objects[0].y;

        for (o in objects) {
            final copy = Objects.getFromCode(o.displayCode);
            copy.x = o.x - offsetX;
            copy.y = o.y - offsetY;
            _group.addChild(copy);
        }

        _group.x = -_group.width/2;
        _group.y = -_group.height/2;
        addChild(_group);
    }

    public override function mouseDownHandler(e:MouseEvent):Dynamic {
        super.mouseDownHandler(e);

        final clickedMenu = _le.menu.hitTestPoint(e.stageX, e.stageY, true);
        if (clickedMenu) {
            return remove();
        }

        final pt = _le.cur.globalToLocal(new Point(e.stageX, e.stageY));
        final offsetX = -_group.width/2;
        final offsetY = -_group.height/2;
        for (i in 0..._group.numChildren) {
            final o = _group.getChildAt(i);
            final bo = _objects[i];
            final x = Std.int(pt.x+o.x+offsetX);
            final y = Std.int(pt.y+o.y+offsetY);
            if (_le.blockBG.isOpen(x, y))
                _le.blockBG.attachObject(bo.displayCode, x, y, bo.getOptionsString());
        }
        return null;
    }
}
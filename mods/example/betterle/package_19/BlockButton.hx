package betterle.package_19;

import ui.CustomCursor;
import flash.events.MouseEvent;
import com.jiggmin.data.Data;
import flash.display.DisplayObject;
import flash.display.Sprite;

final class MyObjects {
    public static inline final DUMMY = 400;

    public static function getFromCode(displayCode:Int):DisplayObject {
        return if (displayCode == DUMMY) {
            new EggBlockGraphic();
        } else {
            null;
        }
    }
}

class BlockButton extends Sprite {
    var _displayCode:Int;
    public function new(displayCode:Int) {
        _displayCode = displayCode;
        super();
        final bg = new Square();
        bg.width = bg.height = 30;
        bg.x = bg.y = 15;
        bg.alpha = 0;
        addChild(bg);
        final obj = MyObjects.getFromCode(displayCode);
        fit(obj);
        addChild(obj);
        addEventListener(MouseEvent.MOUSE_DOWN, select);
    }

    public function fit(obj:DisplayObject) {
        // final loc2 = 24;
        // Data.method_314(obj, loc2, loc2);
        // obj.x = (loc2 - obj.width) / 2 + 3;
        // obj.y = (loc2 - obj.height) / 2 + 3;
    }

    public function select(e:MouseEvent) {
        e.stopImmediatePropagation();
        CustomCursor.change(untyped __new__(__global__["package_20.class_275"], _displayCode));
    }

    public function remove() {
        removeEventListener(MouseEvent.MOUSE_DOWN, select);
        parent.removeChild(this);
    }
}
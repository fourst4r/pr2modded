package io.github.fourst4r;

import flash.events.EventDispatcher;
import flash.geom.Rectangle;
import flash.display.Sprite;
import flash.Lib;
import flash.display.DisplayObject;

class Align {
    public static final LEFT = "left";
    public static final RIGHT = "right";
    public static final TOP = "top";
    public static final BOTTOM = "bottom";
    public static final CENTER = "center";
}

class FlashTools {

    public static inline function addWeakListener<T:EventDispatcher, U>(obj:T, type:String, listener:Dynamic -> Void, useCapture:Bool = false, priority:Int = 0)
        obj.addEventListener(type, listener, useCapture, priority, true);

    public static function alignPivot(s:DisplayObject, horizontalAlign: String = "center", verticalAlign: String = "center", showRegistration: Bool = false, _color: Int = 0x000000): Sprite {

        //create a container sprite to house the sprite you'd like to move
        var _container: Sprite = new Sprite();
        //add your sprite to the continer sprite (the container sprite is what will be returned)
        _container.addChild(s);
        //using getBounds(), find the x,y,width,and height of your sprite within the continer.
        var bounds:Rectangle = _container.getBounds(s);
        //create variables for x and y cooridnates
        var xVal: Float;
        var yVal: Float;

        //I have a separate class called Align which contains public static constants for positiong.
        //Check the values passed above and get the correct x value;
        if (horizontalAlign == Align.LEFT) xVal = -bounds.x;
        else if (horizontalAlign == Align.CENTER) xVal = -bounds.x - bounds.width * .5;
        else if (horizontalAlign == Align.RIGHT) xVal = -bounds.x - bounds.width;
        else throw "Invalid horizontal alignment: " + horizontalAlign;

        //Check the values passed above and get the correct y value;
        if (verticalAlign == Align.TOP) yVal = -bounds.y;
        else if (verticalAlign == Align.CENTER) yVal = -bounds.y - bounds.height * .5;
        else if (verticalAlign == Align.BOTTOM) yVal = -bounds.y - bounds.height;
        else throw "Invalid vertical alignment: " + verticalAlign;

        //apply the new x and y cooridnates to your sprite (the one moving within the container we created above)
        s.x = xVal;
        s.y = yVal;

        //optional - this will create a small X at the 0,0 position of the container.
        //This is helpful if you want to see where your registration points are
        if (showRegistration) {
            var mark: Sprite = new Sprite();
            mark.graphics.lineStyle(1, _color);
            mark.graphics.moveTo(-5, -5);
            mark.graphics.lineTo(5, 5);
            mark.graphics.moveTo(-5, 5);
            mark.graphics.lineTo(5, -5);
            _container.addChild(mark);
        }
        //return your contianer sprite
        //This will replace the sprite that you passed in the first parameter.
        //That sprite is inside the container, so you won't notice
        return _container;


    }

    public static function stageCentered<T:DisplayObject>(obj:T):T {
        return obj;
    }

    public static function centered<T:DisplayObject>(obj:T, origin:DisplayObject):T {
        obj.x = origin.width / 2;
        obj.y = origin.height / 2;
        return obj;
    }

    public static function centeredHoriz(obj:DisplayObject, origin:DisplayObject = null) {
        origin = origin ?? obj.parent ?? Lib.current.stage;
        obj.x = origin.width / 2;
        return obj;
    }

    public static function centeredVert(obj:DisplayObject, origin:DisplayObject = null) {
        origin = origin ?? obj.parent ?? Lib.current.stage;
        obj.y = origin.height / 2;
        return obj;
    }
}
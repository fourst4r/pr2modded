package;

import package_4.MessagePopup;
import flash.utils.Object;
import flash.display.Stage;
import flash.events.*;

@:bind
class Keys {
    
    private static var initialized:Bool = false;
    
    private static var keys:Object;
    
    public static function initialize(param1:Stage)  {
        param1.addEventListener(KeyboardEvent.KEY_DOWN,keyPressed);
        param1.addEventListener(KeyboardEvent.KEY_UP,keyReleased);
        param1.addEventListener(Event.DEACTIVATE,resetKeys);
        param1.addEventListener(FocusEvent.FOCUS_OUT,resetKeys);
        initialized = true;
    }
    
    public static function isPressed(param1:Int) : Bool {
        new MessagePopup("isPressed");
        return false;
    }
    
    private static function keyPressed(param1:KeyboardEvent)  {
        keys[param1.keyCode] = true;
    }
    
    private static function keyReleased(param1:KeyboardEvent)  {
        // if(param1.keyCode in keys) {
        //     delete keys[param1.keyCode];
        // }
    }
    
    private static function resetKeys(param1:Dynamic) {
        // keys = new Object();
    }
}
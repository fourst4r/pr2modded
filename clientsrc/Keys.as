package
{
   import flash.display.Stage;
   import flash.events.*;
   
   public class Keys
   {
      
      public static var initialized:Boolean = false;
      
      public static var keys:Object = new Object();
       
      
      public function Keys()
      {
         super();
      }
      
      public static function initialize(param1:Stage) : *
      {
         param1.addEventListener(KeyboardEvent.KEY_DOWN,keyPressed);
         param1.addEventListener(KeyboardEvent.KEY_UP,keyReleased);
         param1.addEventListener(Event.DEACTIVATE,resetKeys);
         param1.addEventListener(FocusEvent.FOCUS_OUT,resetKeys);
         initialized = true;
      }
      
      public static function isPressed(param1:uint) : Boolean
      {
         if(!initialized)
         {
            return false;
         }
         return Boolean(param1 in keys);
      }
      
      public static function keyPressed(param1:KeyboardEvent) : *
      {
         keys[param1.keyCode] = true;
      }
      
      public static function keyReleased(param1:KeyboardEvent) : *
      {
         if(param1.keyCode in keys)
         {
            delete keys[param1.keyCode];
         }
      }
      
      public static function resetKeys(param1:*) : *
      {
         keys = new Object();
      }
   }
}

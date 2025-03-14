package package_19
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import package_20.*;
   import ui.*;
   
   public class class_228 extends StampButton
   {
       
      
      public function class_228(param1:int)
      {
         super(param1);
      }
      
      override public function fit(param1:DisplayObject) : *
      {
      }
      
      override public function select(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         CustomCursor.change(new class_275(displayCode));
      }
   }
}

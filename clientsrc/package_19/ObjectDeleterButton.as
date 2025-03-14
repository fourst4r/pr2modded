package package_19
{
   import flash.events.*;
   import package_20.*;
   import ui.*;
   
   public class ObjectDeleterButton extends Removable
   {
       
      
      public var m:ObjectDeleterButtonGraphic;
      
      public function ObjectDeleterButton()
      {
         this.m = new ObjectDeleterButtonGraphic();
         super();
         addChild(this.m);
         addEventListener(MouseEvent.MOUSE_DOWN,this.select);
      }
      
      public function select(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         CustomCursor.change(new ObjectDeleter());
      }
      
      override public function remove() : *
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.select);
         super.remove();
      }
   }
}

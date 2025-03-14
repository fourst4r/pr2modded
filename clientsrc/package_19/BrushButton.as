package package_19
{
   import flash.display.Sprite;
   import flash.events.*;
   import levelEditor.*;
   
   public class BrushButton extends Sprite
   {
       
      
      public var editor:LevelEditor;
      
      public function BrushButton()
      {
         this.editor = LevelEditor.editor;
         super();
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         addChild(new BrushGraphic());
      }
      
      public function mouseDownHandler(param1:MouseEvent) : *
      {
         this.editor.menu.changeSideBar(this.editor.menu.tools);
         this.editor.focusOn(this.editor.var_220);
      }
      
      public function remove() : *
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
      }
   }
}

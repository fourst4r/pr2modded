package package_20
{
   import background.ObjectBackground;
   import flash.events.*;
   import levelEditor.*;
   import ui.CustomCursor;
   
   public class ObjectDeleter extends CustomCursor
   {
       
      
      public var var_151:ObjectBackground;
      
      public var editor:LevelEditor;
      
      public function ObjectDeleter()
      {
         this.editor = LevelEditor.editor;
         super();
         applyCursorGraphic(new ObjectDeleterButtonGraphic());
         addEventListener(Event.ENTER_FRAME,this.method_152,false,0,true);
      }
      
      public function method_458() : *
      {
         scaleX = this.editor.scaleX * this.editor.cur.scaleX;
         scaleY = this.editor.scaleY * this.editor.cur.scaleY;
      }
      
      public function method_152(param1:Event) : *
      {
         this.method_458();
      }
      
      override public function mouseDownHandler(param1:MouseEvent) : *
      {
         super.mouseDownHandler(param1);
         if(this.editor.menu.hitTestPoint(param1.stageX,param1.stageY,true))
         {
            this.remove();
         }
         else
         {
            this.var_151 = LevelEditor.editor.cur;
            this.var_151.removeObjectsTouchingPoint(param1.stageX,param1.stageY);
         }
      }
      
      override public function mouseMoveHandler(param1:MouseEvent) : *
      {
         super.mouseMoveHandler(param1);
         if(isMouseDown())
         {
            this.var_151.removeObjectsTouchingPoint(param1.stageX,param1.stageY);
         }
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.method_152);
         this.editor = null;
         this.var_151 = null;
         super.remove();
      }
   }
}

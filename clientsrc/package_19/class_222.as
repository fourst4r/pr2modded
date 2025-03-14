package package_19
{
   import flash.events.MouseEvent;
   import levelEditor.*;
   
   public class class_222 extends StampButton
   {
       
      
      public var color:Number;
      
      public function class_222(param1:int, param2:Number = 0)
      {
         super(param1);
         this.color = param2;
      }
      
      override public function select(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         LevelEditor.editor.setColor(this.color);
         LevelEditor.editor.bg.method_338(displayCode);
      }
   }
}

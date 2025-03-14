package package_20
{
   import levelEditor.*;
   
   public class Eraser extends Brush
   {
       
      
      public function Eraser()
      {
         super();
         color = 16777215;
         mode = "erase";
      }
      
      override public function stopDrawing() : *
      {
         drawing = false;
         LevelEditor.editor.var_220.erase();
      }
   }
}

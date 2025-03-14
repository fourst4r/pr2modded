package levelEditor
{
   import package_4.Popup;
   
   public class DrawingPopup extends Popup
   {
       
      
      public var m:DrawingPopupGraphic;
      
      public function DrawingPopup()
      {
         this.m = new DrawingPopupGraphic();
         super(false);
         addChild(this.m);
      }
   }
}

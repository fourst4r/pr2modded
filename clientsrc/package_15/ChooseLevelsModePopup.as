package package_15
{
   import flash.events.*;
   import package_4.Popup;
   
   public class ChooseLevelsModePopup extends Popup
   {
       
      
      public var m:ChooseLevelsModePopupGraphic;
      
      public function ChooseLevelsModePopup()
      {
         this.m = new ChooseLevelsModePopupGraphic();
         super();
         this.m.reports_bt.addEventListener(MouseEvent.CLICK,this.clickLevelReports,false,0,true);
         this.m.mine_bt.addEventListener(MouseEvent.CLICK,this.clickMyLevels,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         addChild(this.m);
      }
      
      public function clickLevelReports(param1:MouseEvent) : *
      {
         new GetLevelReports();
         startFadeOut();
      }
      
      public function clickMyLevels(param1:MouseEvent) : *
      {
         new GetLevels();
         startFadeOut();
      }
      
      public function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.reports_bt.removeEventListener(MouseEvent.CLICK,this.clickLevelReports);
         this.m.mine_bt.removeEventListener(MouseEvent.CLICK,this.clickMyLevels);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         super.remove();
      }
   }
}

package blocks.options
{
   import blocks.Block;
   import flash.events.*;
   import package_4.*;
   import ui.*;
   
   public class CustomStatsBlockOptions extends BlockOptions
   {
       
      
      protected var speedSlider:StatSlider;
      
      protected var accelSlider:StatSlider;
      
      protected var jumpnSlider:StatSlider;
      
      protected var resetPop:HoverPopup;
      
      public function CustomStatsBlockOptions(param1:Block)
      {
         m = new CustomStatsBlockOptionsGraphic();
         super(param1);
         this.speedSlider = new StatSlider("Speed",null);
         this.accelSlider = new StatSlider("Acceleration",null);
         this.jumpnSlider = new StatSlider("Jumping",null);
         this.speedSlider.x = this.accelSlider.x = this.jumpnSlider.x = -62.75;
         this.speedSlider.y = -40;
         this.accelSlider.y = 0;
         this.jumpnSlider.y = 40;
         m.resetChk.addEventListener(Event.CHANGE,this.onResetClick,false,0,true);
         if(param1.options == "reset")
         {
            m.resetChk.selected = true;
            m.resetChk.dispatchEvent(new Event(Event.CHANGE));
         }
         var _loc2_:Array = param1.getCustomStats();
         this.speedSlider.setValue(_loc2_[0]);
         this.accelSlider.setValue(_loc2_[1]);
         this.jumpnSlider.setValue(_loc2_[2]);
         addChild(this.speedSlider);
         addChild(this.accelSlider);
         addChild(this.jumpnSlider);
         m.resetChk.addEventListener(MouseEvent.MOUSE_OVER,this.onResetMouse,false,0,true);
         m.resetChk.addEventListener(MouseEvent.MOUSE_OUT,this.onResetMouse,false,0,true);
      }
      
      protected function onResetClick(param1:Event) : *
      {
         this.speedSlider.alpha = this.accelSlider.alpha = this.jumpnSlider.alpha = !!m.resetChk.selected ? 0.25 : 1;
         this.speedSlider.mouseEnabled = this.accelSlider.mouseEnabled = this.jumpnSlider.mouseEnabled = !m.resetChk.selected;
         this.speedSlider.mouseChildren = this.accelSlider.mouseChildren = this.jumpnSlider.mouseChildren = !m.resetChk.selected;
      }
      
      protected function onResetMouse(param1:MouseEvent = null) : *
      {
         if(param1 != null && param1.type == MouseEvent.MOUSE_OVER && this.resetPop == null)
         {
            this.resetPop = new HoverPopup("Reset To Starting Stats","Checking this box will reset the bumping player\'s stats to those with which they entered the course.",m.resetChk);
         }
         else if(this.resetPop != null)
         {
            this.resetPop.remove();
            this.resetPop = null;
         }
      }
      
      override public function remove() : *
      {
         this.onResetMouse();
         block.applyOptions(!!m.resetChk.selected ? "reset" : [this.speedSlider.getValue(),this.accelSlider.getValue(),this.jumpnSlider.getValue()].join("-"));
         super.remove();
      }
   }
}

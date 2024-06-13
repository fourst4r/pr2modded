package package_6
{
   import com.jiggmin.data.*;
   import flash.display.Sprite;
   import flash.events.*;
   import package_8.Character;
   
   public class SpectatePicker extends Sprite
   {
       
      
      private var game:Course;
      
      private var m:SpectatePickerGraphic;
      
      private var htmlNameMaker:HTMLNameMaker;
      
      private var pickedID:int = -1;
      
      public function SpectatePicker()
      {
         this.game = Course.course;
         this.htmlNameMaker = new HTMLNameMaker();
         super();
         this.m = new SpectatePickerGraphic();
         this.m.arrowLeft.addEventListener(MouseEvent.CLICK,this.clickLeft,false,0,true);
         this.m.arrowRight.addEventListener(MouseEvent.CLICK,this.clickRight,false,0,true);
         addChild(this.m);
         this.htmlNameMaker.listenForLink(this.m.playerName.top.box);
         this.stopSpectating();
      }
      
      private function clickLeft(param1:MouseEvent) : *
      {
         var _loc2_:int = this.pickedID - 1;
         if(_loc2_ < 0)
         {
            _loc2_ = this.game.playerArray.length - 1;
         }
         this.setPlayer(_loc2_);
      }
      
      private function clickRight(param1:MouseEvent) : *
      {
         var _loc2_:int = this.pickedID + 1;
         if(_loc2_ >= this.game.playerArray.length)
         {
            _loc2_ = 0;
         }
         this.setPlayer(_loc2_);
      }
      
      private function setPlayer(param1:int = -1) : *
      {
         var _loc2_:Character = null;
         if(param1 == this.pickedID)
         {
            return;
         }
         if(param1 == -1 || this.game.playerArray[param1] == null)
         {
            this.stopSpectating();
            return;
         }
         this.pickedID = param1;
         _loc2_ = this.game.playerArray[this.pickedID];
         this.m.spectatingText.visible = true;
         this.m.playerName.top.box.htmlText = this.m.playerName.bg.box.htmlText = "&nbsp;" + this.htmlNameMaker.makeName(_loc2_.getName(),_loc2_.getGroup()) + "&nbsp;";
         this.game.changeSpectate(this.pickedID);
      }
      
      public function stopSpectating() : *
      {
         this.pickedID = -1;
         this.m.playerName.top.box.htmlText = this.m.playerName.bg.box.htmlText = "Free Scroll";
         this.m.spectatingText.visible = false;
      }
      
      public function toggleVisibility(param1:Boolean) : *
      {
         this.m.visible = param1;
         if(this.m.visible)
         {
            this.stopSpectating();
         }
      }
      
      public function remove() : *
      {
         this.m.arrowLeft.removeEventListener(MouseEvent.CLICK,this.clickLeft);
         this.m.arrowRight.removeEventListener(MouseEvent.CLICK,this.clickRight);
         this.m = null;
      }
   }
}

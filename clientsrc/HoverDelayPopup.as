package
{
   import flash.display.Sprite;
   import flash.events.*;
   import flash.utils.*;
   import package_4.*;
   
   public class HoverDelayPopup extends Sprite
   {
       
      
      public var title:String;
      
      public var content:String;
      
      public var time:int = 500;
      
      public var delayTimer:uint;
      
      public var hover:HoverPopup;
      
      public function HoverDelayPopup(param1:String = "", param2:String = "", param3:int = 500)
      {
         super();
         this.title = param1;
         this.content = param2;
         this.time = param3;
         addEventListener(MouseEvent.MOUSE_OVER,this.overHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.outHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.downHandler,false,0,true);
      }
      
      public function overHandler(param1:MouseEvent) : *
      {
         clearTimeout(this.delayTimer);
         this.delayTimer = setTimeout(this.showPopup,this.time);
         this.hidePopupIfShown();
      }
      
      public function outHandler(param1:MouseEvent) : *
      {
         clearTimeout(this.delayTimer);
         this.hidePopupIfShown();
      }
      
      public function downHandler(param1:MouseEvent) : *
      {
         clearTimeout(this.delayTimer);
         this.hidePopupIfShown();
      }
      
      public function showPopup() : *
      {
         this.hidePopupIfShown();
         this.hover = new HoverPopup(this.title,this.content,this);
      }
      
      public function hidePopupIfShown() : *
      {
         if(this.hover != null)
         {
            this.hover.remove();
         }
      }
      
      public function remove() : *
      {
         clearTimeout(this.delayTimer);
         removeEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
         this.hidePopupIfShown();
         if(this.parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}

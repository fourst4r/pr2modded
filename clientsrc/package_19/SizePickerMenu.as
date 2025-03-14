package package_19
{
   import fl.events.*;
   import flash.events.*;
   import package_4.class_264;
   
   public class SizePickerMenu extends class_264
   {
       
      
      public var m:SizePickerMenuGraphic;
      
      public var target:SizePicker;
      
      public function SizePickerMenu(param1:SizePicker, param2:Number = 4)
      {
         this.m = new SizePickerMenuGraphic();
         this.target = param1;
         this.setSize(param2);
         addChild(this.m);
         super(this.target);
         this.m.slider.addEventListener(SliderEvent.CHANGE,this.slideChange);
         this.m.textBox.addEventListener(Event.CHANGE,this.textChange);
      }
      
      public function slideChange(param1:SliderEvent) : *
      {
         this.setSize(param1.value);
      }
      
      public function textChange(param1:Event) : *
      {
         this.setSize(param1.target.text);
      }
      
      public function setSize(param1:Number) : *
      {
         param1 = Math.round(param1);
         param1 = param1 < 1 ? 1 : param1;
         param1 = param1 > 255 ? 255 : param1;
         this.m.textBox.text = param1.toString();
         this.m.slider.value = param1;
         this.target.setSize(param1);
      }
      
      override public function remove() : *
      {
         Main.stage.focus = Main.stage;
         this.m.slider.removeEventListener(SliderEvent.CHANGE,this.slideChange);
         this.m.textBox.removeEventListener(Event.CHANGE,this.textChange);
         super.remove();
      }
   }
}

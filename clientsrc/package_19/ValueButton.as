package package_19
{
   import flash.events.MouseEvent;
   
   public class ValueButton extends class_215
   {
       
      
      public var value:String;
      
      public var title:String;
      
      public var description:String;
      
      public var defineCommand:Function;
      
      public var maxChars:Number;
      
      public var restrictTo:String;
      
      public var defaultVal:String;
      
      public var displayAsPassword:Boolean;
      
      public var m:ValueButtonGraphic;
      
      public function ValueButton(param1:String, param2:String, param3:String, param4:String, param5:Function, param6:Number = 9, param7:String = "0123456789", param8:String = "0", param9:Boolean = false)
      {
         this.m = new ValueButtonGraphic();
         super();
         this.value = param4;
         this.title = param2;
         this.description = param3;
         this.defineCommand = param5;
         this.maxChars = param6;
         this.restrictTo = param7;
         this.defaultVal = param8;
         this.displayAsPassword = param9;
         this.m.titleBox.text = param1;
         this.m.valueBox.text = param4;
         this.m.valueBox.displayAsPassword = param9;
         addChild(this.m);
      }
      
      public function setValue(param1:String) : *
      {
         this.value = param1;
         this.m.valueBox.text = param1;
      }
      
      override public function onClick(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         new ValueMenu(this,this.title,this.description,this.value,this.defineCommand,this.maxChars,this.restrictTo,this.defaultVal,this.displayAsPassword);
      }
   }
}

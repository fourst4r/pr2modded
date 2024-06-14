package package_6
{
   import com.jiggmin.data.*;
   import flash.events.*;
   
   public class ExpGain extends Removable
   {
       
      
      protected var m:ExpGainGraphic;
      
      protected var expStart:Number;
      
      protected var expEnd:Number;
      
      protected var expToRank:Number;
      
      protected var var_575:Number;
      
      public function ExpGain()
      {
         this.m = new ExpGainGraphic();
         super();
         addChild(this.m);
         this.m.bar.bar.width = 1;
      }
      
      public function start(param1:Number, param2:Number, param3:Number) : *
      {
         this.expStart = param1;
         this.expEnd = param2;
         this.expToRank = param3;
         if(this.expEnd > this.expToRank)
         {
            this.expEnd = this.expToRank;
         }
         if(this.expStart > this.expToRank)
         {
            this.expStart = this.expToRank;
         }
         if(this.expStart <= this.expEnd)
         {
            this.var_575 = (this.expEnd - this.expStart) / 45;
            addEventListener(Event.ENTER_FRAME,this.go);
         }
      }
      
      protected function go(param1:Event) : *
      {
         this.expStart += this.var_575;
         if(this.expStart >= this.expEnd)
         {
            removeEventListener(Event.ENTER_FRAME,this.go);
            this.expStart = this.expEnd;
         }
         this.m.textBox.text = Data.formatNumber(Math.floor(this.expStart)) + " / " + Data.formatNumber(this.expToRank);
         this.m.bar.bar.width = 200 * (this.expStart / this.expToRank);
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.go);
         super.remove();
      }
   }
}

package package_8
{
   public class class_127
   {
       
      
      public var character:Character;
      
      public var hat:class_125;
      
      public var head:class_125;
      
      public var body:class_125;
      
      public var foot1:class_125;
      
      public var foot2:class_125;
      
      public var djinnBody:Object;
      
      public var djinnFeet:Object;
      
      public function class_127(param1:Character)
      {
         super();
         this.character = param1;
         this.djinnBody = new Object();
         this.djinnBody.graphic = "DjinnIceGraphic";
         this.djinnBody.colors = new Array(this.character.bodyColor,this.character.bodyColor2);
         this.djinnBody.life = 16;
         this.djinnBody.startAlpha = 0.1;
         this.djinnBody.minVelAlpha = 0;
         this.djinnBody.maxVelAlpha = 0.5;
         this.djinnBody.minVelY = 2;
         this.djinnBody.maxVelY = 3;
         this.djinnBody.velScaleX = 0.1;
         this.djinnBody.velScaleY = 0.1;
         this.djinnBody.fricY = 0.9;
         this.djinnBody.fricX = 1.05;
         this.djinnBody.minOffsetX = -5;
         this.djinnBody.maxOffsetX = 5;
         this.djinnBody.minOffsetY = -10;
         this.djinnBody.maxOffsetY = 10;
         this.djinnBody.minScale = -1;
         this.djinnBody.maxScale = -0.75;
         this.djinnFeet = new Object();
         this.djinnFeet.graphic = "DjinnIceGraphic";
         this.djinnFeet.colors = new Array(this.character.feetColor,this.character.feetColor2);
         this.djinnFeet.life = 8;
         this.djinnFeet.startAlpha = 0.1;
         this.djinnFeet.minVelAlpha = 0;
         this.djinnFeet.maxVelAlpha = 0.5;
         this.djinnFeet.minVelX = -2;
         this.djinnFeet.maxVelX = 2;
         this.djinnFeet.velScaleX = 0.1;
         this.djinnFeet.velScaleY = 0.1;
         this.djinnFeet.minOffsetX = -5;
         this.djinnFeet.maxOffsetX = 5;
         this.djinnFeet.minOffsetY = -5;
         this.djinnFeet.maxOffsetY = 5;
         this.djinnFeet.minScale = 0.075;
         this.djinnFeet.maxScale = 0.1;
      }
      
      public function update() : *
      {
         this.clear();
         if(Boolean(this.character.parent) && Boolean(this.character.var_301))
         {
            if(this.character.body == 35)
            {
               this.djinnBody.colors = new Array(this.character.bodyColor,this.character.bodyColor2);
               this.body = new class_179(75,9999999999,this.character.var_301.body,this.character.parent,this.djinnBody,-15,-10);
            }
            if(this.character.feet == 35)
            {
               this.djinnFeet.colors = new Array(this.character.feetColor,this.character.feetColor2);
               this.foot1 = new class_179(75,9999999999,this.character.var_301.foot1,this.character.parent,this.djinnFeet);
               this.foot2 = new class_179(75,9999999999,this.character.var_301.foot2,this.character.parent,this.djinnFeet);
            }
         }
      }
      
      public function newAlpha(param1:Number) : *
      {
         this.djinnBody.startAlpha = this.djinnFeet.startAlpha = param1 / 5;
         this.djinnBody.minVelAlpha = this.djinnFeet.minVelAlpha = 0;
         this.djinnBody.maxVelAlpha = this.djinnFeet.maxVelAlpha = param1;
      }
      
      public function clear() : *
      {
         if(this.hat)
         {
            this.hat.remove();
            this.hat = null;
         }
         if(this.head)
         {
            this.head.remove();
            this.head = null;
         }
         if(this.body)
         {
            this.body.remove();
            this.body = null;
         }
         if(this.foot1)
         {
            this.foot1.remove();
            this.foot1 = null;
         }
         if(this.foot2)
         {
            this.foot2.remove();
            this.foot2 = null;
         }
      }
      
      public function remove() : *
      {
         this.clear();
         this.character = null;
      }
   }
}

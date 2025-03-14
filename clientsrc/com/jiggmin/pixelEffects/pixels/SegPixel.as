package com.jiggmin.pixelEffects.pixels
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class SegPixel extends Sprite
   {
       
      
      public var bitmap:Bitmap;
      
      public var src:BitmapData;
      
      public var product:BitmapData;
      
      public var finalX:Number;
      
      public var finalY:Number;
      
      public var pull:Number;
      
      public var glintFrames:int = 20;
      
      public var glintCounter:Number;
      
      public function SegPixel(param1:BitmapData, param2:BitmapData, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number)
      {
         this.glintCounter = this.glintFrames;
         super();
         this.finalX = param7;
         this.finalY = param8;
         this.pull = param9;
         this.src = param1;
         this.product = param2;
         alpha = 0;
         this.bitmap = new Bitmap(param1);
         addChild(this.bitmap);
         x = param3;
         y = param4;
         scaleX = param5;
         scaleY = param6;
         addEventListener(Event.ENTER_FRAME,this.go);
      }
      
      public function go(param1:Event) : *
      {
         if(Math.abs(x - this.finalX) < 1 && Math.abs(y - this.finalY) < 1)
         {
            this.settle();
         }
         else
         {
            x -= (x - this.finalX) * this.pull;
            y -= (y - this.finalY) * this.pull;
            scaleX -= (scaleX - 1) * this.pull;
            scaleY -= (scaleY - 1) * this.pull;
            alpha -= (alpha - 1) * this.pull;
         }
      }
      
      public function settle() : *
      {
         x = this.finalX;
         y = this.finalY;
         scaleX = scaleY = 1;
         alpha = 1;
         removeEventListener(Event.ENTER_FRAME,this.go);
         addEventListener(Event.ENTER_FRAME,this.glint);
         var _loc1_:Point = new Point(this.finalX,this.finalY);
         this.product.copyPixels(this.src,this.src.rect,_loc1_);
         this.src.fillRect(this.src.rect,16777215);
         alpha = 0.25;
      }
      
      public function glint(param1:Event) : *
      {
         --this.glintCounter;
         if(this.glintCounter > 0)
         {
            alpha = this.glintCounter / this.glintFrames / 2;
         }
         else
         {
            this.remove();
         }
      }
      
      public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.glint);
         removeEventListener(Event.ENTER_FRAME,this.go);
         this.src.dispose();
         removeChild(this.bitmap);
         parent.removeChild(this);
      }
   }
}

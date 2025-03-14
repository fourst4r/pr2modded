package blocks
{
   import flash.geom.*;
   import package_8.LocalCharacter;
   
   public class SupplyBlock extends Block
   {
       
      
      public var uses:int = 1;
      
      public function SupplyBlock(param1:int)
      {
         super(param1);
      }
      
      override public function onBump(param1:LocalCharacter) : *
      {
         super.onBump(param1);
         if(!(this is TeleportBlock))
         {
            this.maybeUseSupply(param1);
         }
      }
      
      public function maybeUseSupply(param1:LocalCharacter) : *
      {
         if(!frozen)
         {
            if(this.uses > 0)
            {
               --this.uses;
               this.useSupply(param1);
            }
            if(this.uses <= 0)
            {
               this.method_789();
            }
         }
      }
      
      public function useSupply(param1:LocalCharacter) : *
      {
      }
      
      public function resetSupply(param1:int = 1) : *
      {
         this.uses = param1;
         transform.colorTransform = new ColorTransform();
      }
      
      public function method_789() : *
      {
         transform.colorTransform = new ColorTransform(0.5,0.5,0.5);
      }
   }
}

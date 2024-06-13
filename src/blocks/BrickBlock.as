package blocks
{
   import com.jiggmin.data.*;
   import flash.geom.Point;
   import package_8.LocalCharacter;
   import package_9.*;
   
   public class BrickBlock extends Block
   {
       
      
      public function BrickBlock()
      {
         super(Objects.BLOCK_BRICK);
         safeStand = false;
      }
      
      override public function onBump(param1:LocalCharacter) : *
      {
         super.onBump(param1);
         if(!frozen)
         {
            localActivate();
         }
      }
      
      override public function onDamage(param1:Number) : *
      {
         super.onDamage(param1);
         if(!frozen)
         {
            localActivate();
         }
      }
      
      override protected function activate(param1:String = "") : *
      {
         var _loc3_:int = 0;
         var _loc4_:BrickPieceGraphic = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:BlockPiece = null;
         var _loc2_:Point = method_18();
         while(_loc3_ < 6)
         {
            _loc4_ = new BrickPieceGraphic();
            _loc5_ = Math.random() * 30 + _loc2_.x;
            _loc6_ = Math.random() * 30 + _loc2_.y;
            _loc7_ = new BlockPiece(_loc4_,0.75,0.95,0.05,10,10,25,_loc5_,_loc6_);
            _loc3_++;
         }
         remove();
      }
   }
}

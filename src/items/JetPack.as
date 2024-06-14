package items
{
   import com.jiggmin.data.*;
   import package_8.LocalCharacter;
   
   public class JetPack extends Item
   {
       
      
      protected var spaceDown:Boolean = false;
      
      public function JetPack(param1:LocalCharacter)
      {
         super(param1);
         class_33.setNumber("totFuel",200);
         class_33.setNumber("fuel",200);
         param1.setAmmo(3);
      }
      
      override public function setSpace(param1:Boolean) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1 && !character.crouching)
         {
            super.setSpace(space);
            character.velY -= character.velY > -5 ? 1.25 : 0.5;
            _loc2_ = Number(class_33.getNumber("totFuel"));
            _loc3_ = Number(class_33.getNumber("fuel"));
            _loc3_--;
            class_33.setNumber("fuel",_loc3_);
            character.setAmmo(Math.ceil(_loc3_ / _loc2_ * 3));
            if(_loc3_ <= 0)
            {
               super.useItem();
            }
         }
         if(param1 != this.spaceDown)
         {
            this.spaceDown = param1;
            if(character != null)
            {
               if(param1)
               {
                  character.beginJet();
               }
               else
               {
                  character.endJet();
               }
            }
         }
      }
      
      override public function useItem() : *
      {
      }
      
      public function replenishFuel(param1:LocalCharacter) : *
      {
         class_33.setNumber("totFuel",200);
         class_33.setNumber("fuel",200);
         param1.setAmmo(3);
      }
      
      override public function remove() : *
      {
         character.endJet();
         super.remove();
      }
   }
}

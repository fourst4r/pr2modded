package blocks
{
   import blocks.options.*;
   import com.jiggmin.data.*;
   import package_8.LocalCharacter;
   import page.*;
   import sounds.*;
   
   public class ItemBlock extends SupplyBlock
   {
       
      
      public function ItemBlock(param1:int = 110)
      {
         optionsMenu = ItemBlockOptions;
         super(param1);
      }
      
      public function applyOptions(param1:String) : *
      {
         if(GamePage.course == null)
         {
            return;
         }
         var _loc2_:Vector.<int> = Vector.<int>(param1.split("-")).sort(Array.NUMERIC);
         var _loc3_:Vector.<int> = Vector.<int>(options.split("-")).sort(Array.NUMERIC);
         var _loc4_:Vector.<int> = GamePage.course.allowedItems.sort(Array.NUMERIC);
         if(_loc2_.toString() == _loc4_.toString() || _loc2_.toString() == "0" && _loc4_.toString() == "")
         {
            options = "";
         }
         else
         {
            if(_loc2_ == _loc3_)
            {
               return;
            }
            if(_loc2_.length == 0 || _loc2_.length == 1 && _loc2_[0] == 0)
            {
               options = "none";
            }
            else
            {
               options = _loc2_.join("-");
            }
         }
      }
      
      public function updateGameItems() : *
      {
         var _loc1_:Vector.<int> = GamePage.course.allowedItems.sort(Array.NUMERIC);
         if(options == "")
         {
            return;
         }
         if(options == _loc1_.join("-") || options == "none" && _loc1_.length == 0)
         {
            options = "";
         }
      }
      
      override protected function useSupply(param1:LocalCharacter) : *
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         super.useSupply(param1);
         var _loc2_:Vector.<int> = new Vector.<int>();
         if(options == "")
         {
            _loc2_ = GamePage.course.allowedItems.sort(Array.NUMERIC);
         }
         else if(options != "none")
         {
            _loc2_ = Vector.<int>(options.split("-"));
         }
         if(_loc2_.length > 0)
         {
            _loc3_ = Math.floor(Math.random() * _loc2_.length);
            _loc4_ = _loc2_[_loc3_];
            param1.setItem(_loc4_);
         }
         SoundEffects.playSound(new StarSound(),0.6 * (Settings.soundLevel / 100));
      }
   }
}

package items
{
   import background.*;
   import com.jiggmin.data.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_8.LocalCharacter;
   
   public class Item extends Removable
   {
       
      
      protected var character:LocalCharacter;
      
      protected var space:Boolean = false;
      
      protected var reloading:Boolean = false;
      
      private var reloadListener:uint;
      
      private var available:Boolean = false;
      
      public function Item(param1:LocalCharacter)
      {
         super();
         this.character = param1;
         this.setReloadTime(10);
         this.setUses(1);
      }
      
      public function setSpace(param1:Boolean) : *
      {
         this.space = param1;
         if(!this.space)
         {
            this.available = true;
         }
         var _loc2_:int = int(class_33.getNumber("uses"));
         if(Boolean(this.space) && _loc2_ > 0 && !this.reloading && Boolean(this.available))
         {
            this.useItem();
         }
      }
      
      protected function setUses(param1:int) : *
      {
         class_33.setNumber("uses",param1);
         this.character.setAmmo(param1);
      }
      
      protected function setReloadTime(param1:int) : *
      {
         class_33.setNumber("reloadTime",param1);
      }
      
      public function useItem() : *
      {
         var _loc1_:int = int(class_33.getNumber("uses"));
         _loc1_--;
         class_33.setNumber("uses",_loc1_);
         this.character.setAmmo(_loc1_);
         if(_loc1_ <= 0)
         {
            this.character.setItem(0);
         }
         else
         {
            this.reloading = true;
            this.reloadListener = setTimeout(this.reloadingOnComplete,class_33.getNumber("reloadTime"));
         }
      }
      
      private function reloadingOnComplete() : *
      {
         this.reloading = false;
      }
      
      protected function method_37() : Point
      {
         var _loc1_:Point = new Point(this.character.curWeapon.x,this.character.curWeapon.y);
         _loc1_ = this.character.curWeapon.parent.localToGlobal(_loc1_);
         return EffectBackground.instance.globalToLocal(_loc1_);
      }
      
      override public function remove() : *
      {
         clearTimeout(this.reloadListener);
         if(this.character != null)
         {
            this.character = null;
         }
         super.remove();
      }
   }
}

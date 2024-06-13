package items
{
   import com.jiggmin.data.*;
   import package_8.LocalCharacter;
   import sounds.*;
   
   public class SuperJump extends Item
   {
       
      
      public function SuperJump(param1:LocalCharacter)
      {
         super(param1);
      }
      
      override public function useItem() : *
      {
         if(!character.crouching)
         {
            SoundEffects.playSound(new SuperJumpSound(),Settings.soundLevel / 100);
            character.velY -= 25;
            super.useItem();
         }
      }
   }
}

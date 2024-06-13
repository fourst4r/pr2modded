package blocks
{
   import blocks.options.*;
   import com.jiggmin.data.*;
   import package_6.*;
   import package_8.LocalCharacter;
   import sounds.*;
   
   public class CustomStatsBlock extends SupplyBlock
   {
       
      
      private var customStats:Array;
      
      public function CustomStatsBlock()
      {
         this.customStats = [50,50,50];
         optionsMenu = CustomStatsBlockOptions;
         super(Objects.BLOCK_CUSTOM_STATS);
      }
      
      public function getCustomStats() : *
      {
         return this.customStats;
      }
      
      public function applyOptions(param1:String) : *
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(param1 != "reset")
         {
            _loc2_ = param1.split("-");
            for(_loc3_ in _loc2_)
            {
               _loc2_[_loc3_] = Data.numLimit(int(_loc2_[_loc3_]),0,100);
            }
            this.customStats = _loc2_;
            options = this.customStats != [50,50,50] ? String(this.customStats.join("-")) : "";
         }
         else
         {
            options = "reset";
         }
      }
      
      override protected function useSupply(param1:LocalCharacter) : *
      {
         super.useSupply(param1);
         if(options == "reset")
         {
            param1.resetStatsToStart();
         }
         else
         {
            param1.setStats(this.customStats[0],this.customStats[1],this.customStats[2]);
         }
         if(Course.course != null && Course.course is TestCourse)
         {
            Course.course.statsSelectSetFromCharacter();
         }
         SoundEffects.playSound(new StarSound(),0.6 * (Settings.soundLevel / 100));
      }
   }
}

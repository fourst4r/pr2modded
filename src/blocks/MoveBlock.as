package blocks
{
   import background.Map;
   import com.jiggmin.data.*;
   
   public class MoveBlock extends Block
   {
       
      
      private var arrow:MoveArrow;
      
      private var dir:int;
      
      public function MoveBlock()
      {
         this.arrow = new MoveArrow();
         super(Objects.BLOCK_MOVE);
         safeStand = false;
      }
      
      public function setDirection(param1:int) : *
      {
         this.dir = param1;
         this.displayArrow();
      }
      
      public function shift(param1:Map) : *
      {
         this.removeArrow();
         if(this.dir == 3)
         {
            move(-1,0,param1);
         }
         else if(this.dir == 2)
         {
            move(1,0,param1);
         }
         else if(this.dir == 1)
         {
            move(0,-1,param1);
         }
         else if(this.dir == 0)
         {
            move(0,1,param1);
         }
      }
      
      private function displayArrow() : *
      {
         addChild(this.arrow);
         this.arrow.x = this.arrow.y = 15;
         if(this.dir == 3)
         {
            this.arrow.rotation = 270;
         }
         else if(this.dir == 2)
         {
            this.arrow.rotation = 90;
         }
         else if(this.dir == 1)
         {
            this.arrow.rotation = 0;
         }
         else if(this.dir == 0)
         {
            this.arrow.rotation = 180;
         }
      }
      
      private function removeArrow() : *
      {
         if(this.arrow.parent != null)
         {
            this.arrow.parent.removeChild(this.arrow);
         }
      }
      
      override public function remove() : *
      {
         this.removeArrow();
         super.remove();
      }
   }
}

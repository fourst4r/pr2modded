package background
{
   import blocks.*;
   import com.jiggmin.data.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_6.*;
   import package_8.Character;
   import package_9.*;
   
   public class Map extends BlockBackground
   {
       
      
      private var startBlockNum:int = 0;
      
      private var miniMap:MiniMap;
      
      private var moveInterval:uint;
      
      private var segSize:Number = 30;
      
      public var maxY:Number = -9999999;
      
      public var minY:Number = 9999999;
      
      public var maxX:Number = -9999999;
      
      public var minX:Number = 9999999;
      
      private var moveBlocksArray:Vector.<MoveBlock>;
      
      private var startTime:int;
      
      private var moves:int = 0;
      
      private var moveTime:int = 5000;
      
      private var rand:Random;
      
      private var placedEggs:int = 0;
      
      private var eggPtsArray:Array;
      
      public function Map(param1:MiniMap, param2:Course)
      {
         this.moveBlocksArray = new Vector.<MoveBlock>();
         this.rand = new Random(1);
         this.eggPtsArray = new Array();
         this.miniMap = param1;
         super(param2);
         CommandHandler.commandHandler.defineCommand("activate",this.activate);
      }
      
      public function activate(param1:Array) : *
      {
         var _loc2_:int = int(param1[0]);
         var _loc3_:int = int(param1[1]);
         var _loc4_:String = String(param1[2]);
         var _loc5_:Block;
         if((_loc5_ = getBlockFromSeg(_loc2_,_loc3_)) != null)
         {
            _loc5_.remoteActivate(_loc4_);
         }
      }
      
      override protected function addStartPositions() : *
      {
      }
      
      public function placeBlock(param1:int, param2:Number, param3:Number) : *
      {
         this.attachObject(param1,param2,param3);
      }
      
      override protected function attachObject(param1:int, param2:int, param3:int, param4:String = "") : *
      {
         var _loc6_:Block = null;
         var _loc7_:FinishBlock = null;
         var _loc8_:int = 0;
         if(param1 < 100)
         {
            param1 += 100;
         }
         var _loc5_:Point = getSegFromPos(param2,param3);
         if(param1 == Objects.BLOCK_MINION_EGG)
         {
            this.eggPtsArray.push(new Point(param2,param3));
         }
         else if((_loc6_ = Block(Objects.getFromCode(param1))) is StartBlock)
         {
            this.setStartPos(this.startBlockNum,param2 + 15,param3 + 15);
            ++this.startBlockNum;
         }
         else
         {
            if(_loc6_ is FinishBlock)
            {
               _loc7_ = FinishBlock(_loc6_);
               this.addFinish(_loc7_.getId(),param2 + 15,param3 + 15);
            }
            if(_loc6_.hasOptions && param4 != "")
            {
               _loc6_.applyOptions(param4);
            }
            addToBlockArray(_loc6_,_loc5_);
            if(!_loc6_.isInitialized())
            {
               _loc6_.initialize(_loc5_.x,_loc5_.y,this);
            }
            if(method_32(_loc5_.x,_loc5_.y))
            {
               addChild(_loc6_);
            }
            if(_loc6_ is MoveBlock)
            {
               this.moveBlocksArray.push(_loc6_);
            }
            if(_loc6_ is TeleportBlock)
            {
               _loc8_ = int(_loc6_.getColor());
               if(!Course.course.teleportBlocks.hasOwnProperty(_loc8_))
               {
                  Course.course.teleportBlocks[_loc8_] = [];
               }
               Course.course.teleportBlocks[_loc8_].push(_loc6_);
               _loc6_.blockNum = Course.course.teleportBlocks[_loc8_].length - 1;
            }
            this.miniMap.method_680(param1,param2,param3);
         }
         if(param3 > this.maxY)
         {
            this.maxY = param3;
         }
         else if(param3 < this.minY)
         {
            this.minY = param3;
         }
         if(param2 > this.maxX)
         {
            this.maxX = param2;
         }
         else if(param2 < this.minX)
         {
            this.minX = param2;
         }
      }
      
      private function placeEggs() : *
      {
         var _loc1_:Point = null;
         for each(_loc1_ in this.eggPtsArray)
         {
            this.attachEgg(_loc1_.x + 15,_loc1_.y + 15);
         }
         this.eggPtsArray = new Array();
      }
      
      private function attachEgg(param1:int, param2:int) : *
      {
         var _loc3_:Egg = null;
         if(this.placedEggs < 25)
         {
            _loc3_ = new Egg();
            _loc3_.posX = param1 + 15;
            _loc3_.posY = param2 + 15;
            _loc3_.rot = 0;
            _loc3_.setLimits();
            ++this.placedEggs;
         }
      }
      
      private function setStartPos(param1:int, param2:int, param3:int) : *
      {
         Course.course.addStartPos(param1,new Point(param2,param3));
      }
      
      private function addFinish(param1:int, param2:int, param3:int) : *
      {
         Course.course.finishBlocks.push({
            "id":param1,
            "x":param2,
            "y":param3
         });
      }
      
      override public function draw(param1:Number = 50) : *
      {
         super.draw(param1);
         if(var_39 >= saveArray.length)
         {
            this.miniMap.rasterize();
         }
      }
      
      public function method_578() : *
      {
         this.startTime = new Date().time;
         this.determineMoveBlockDirection();
         this.placeEggs();
      }
      
      private function determineMoveBlockDirection() : *
      {
         var _loc3_:MoveBlock = null;
         var _loc4_:int = 0;
         var _loc1_:int = int(this.moveBlocksArray.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.moveBlocksArray[_loc2_];
            _loc4_ = int(this.rand.nextMinMax(0,4));
            _loc3_.setDirection(_loc4_);
            _loc2_++;
         }
         this.setMoveInterval(this.doMoveBlocks,1000);
      }
      
      private function doMoveBlocks() : *
      {
         var _loc3_:MoveBlock = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.moveBlocksArray.length)
         {
            _loc3_ = this.moveBlocksArray[_loc1_];
            _loc3_.shift(this);
            _loc1_++;
         }
         var _loc2_:int = this.startTime + this.moves * this.moveTime - new Date().time;
         if(_loc2_ < 1)
         {
            _loc2_ = 1;
         }
         this.setMoveInterval(this.determineMoveBlockDirection,_loc2_ + this.moveTime);
         ++this.moves;
      }
      
      override public function testMove(param1:int, param2:int) : Boolean
      {
         return (blockArray[param1] == null || blockArray[param1][param2] == null) && !this.characterOccupiesSpace(param1,param2);
      }
      
      public function characterOccupiesSpace(param1:int, param2:int) : Boolean
      {
         var _loc3_:Character = null;
         if(Course.course != null)
         {
            for each(_loc3_ in Course.course.playerArray)
            {
               if(_loc3_ != null && !_loc3_.removed && (_loc3_.seg1 != null && _loc3_.seg1.x == param1 && _loc3_.seg1.y == param2 || _loc3_.seg2 != null && _loc3_.seg2.x == param1 && _loc3_.seg2.y == param2))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function setMoveInterval(param1:Function, param2:int) : *
      {
         this.clearMoveInterval();
         this.moveInterval = setTimeout(param1,param2);
      }
      
      public function clearMoveInterval() : *
      {
         clearTimeout(this.moveInterval);
      }
      
      override public function clear() : *
      {
         var _loc1_:Block = null;
         while(numChildren > 0)
         {
            _loc1_ = Block(getChildAt(0));
            _loc1_.remove();
         }
         var_39 = 0;
         blockArray = new Array();
         objArray = new Array();
      }
      
      override public function remove() : *
      {
         CommandHandler.commandHandler.defineCommand("activate",null);
         this.moveBlocksArray = null;
         this.clearMoveInterval();
         this.miniMap = null;
         super.remove();
      }
   }
}

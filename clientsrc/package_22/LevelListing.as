package package_22
{
   import com.adobe.crypto.*;
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   import page.Page;
   import ui.*;
   
   public class LevelListing extends Page
   {
      
      public static var levelListing:LevelListing;
       
      
      public var class_10:Sprite;
      
      protected var loadingGraphic:LoadingGraphic;
      
      protected var pageNavigation:PageNavigation;
      
      protected var var_280:uint;
      
      protected var levelArray:Array;
      
      public var levels:Object;
      
      protected var pageNum:int = 1;
      
      protected var mode:String = "best";
      
      protected var superLoader:SuperLoader;
      
      protected var cm:CommandHandler;
      
      public function LevelListing()
      {
         this.class_10 = new Sprite();
         this.loadingGraphic = new LoadingGraphic();
         this.levelArray = new Array();
         this.levels = new Object();
         this.cm = CommandHandler.commandHandler;
         this.pageNavigation = new PageNavigation(this,"vertical",1,9,283);
         this.superLoader = new SuperLoader(true,SuperLoader.j);
         super();
         addChild(this.class_10);
         this.loadingGraphic.x = 164;
         this.loadingGraphic.y = 150;
         addChild(this.loadingGraphic);
         this.pageNavigation.x = 328;
         this.pageNavigation.y = 26;
         addChild(this.pageNavigation);
         this.superLoader.addEventListener(Event.COMPLETE,this.loadHandler);
         this.superLoader.addEventListener(SuperLoader.e,this.errorHandler);
         Main.socket.write("set_right_room`none");
         LevelListing.levelListing = this;
         addEventListener("testLevelAccess",this.testLevelAccess,false,0,true);
         this.cm.defineCommand("addPageHighlight",this.addPageHighlight);
         this.cm.defineCommand("removePageHighlight",this.removePageHighlight);
      }
      
      override public function initialize() : *
      {
         var _loc1_:int = int(Memory.memory["coursePageNum" + this.mode]);
         if(_loc1_ != 0)
         {
            this.pageNavigation.setPageNum(_loc1_);
         }
      }
      
      protected function showCourses(param1:Array) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:LevelItem = null;
         if(class_33.getNumber("userRank") < 0)
         {
            this.var_280 = setTimeout(this.showCourses,250,param1);
         }
         else
         {
            if(this.pageNavigation.parent == this.class_10)
            {
               this.class_10.removeChild(this.pageNavigation);
            }
            _loc2_ = 0;
            _loc3_ = 0;
            if((_loc4_ = this.class_10.height) != 0)
            {
               _loc4_ += 20;
            }
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               _loc6_ = param1[_loc5_];
               if(_loc4_ + _loc3_ * 112 > 224)
               {
                  break;
               }
               (_loc7_ = new LevelItem(_loc6_.level_id,_loc6_.version,_loc6_.title,_loc6_.rating,_loc6_.play_count,_loc6_.min_level,_loc6_.note,_loc6_.user_name,_loc6_.user_group,_loc6_.pass,_loc6_.type,_loc6_.bad_hats,_loc6_.time)).x = 2 + _loc2_ * 109;
               _loc7_.y = _loc4_ + _loc3_ * 112;
               this.levelArray.push(_loc7_);
               this.levels["c" + _loc7_.courseID] = _loc7_;
               this.class_10.addChild(_loc7_);
               _loc2_++;
               if(_loc2_ >= 3)
               {
                  _loc3_++;
                  _loc2_ = 0;
               }
               _loc5_++;
            }
            Main.socket.write("set_right_room`" + (this.mode == "favorites" ? "search" : this.mode));
            this.loadingGraphic.visible = false;
         }
      }
      
      protected function loadHandler(param1:Event) : *
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc2_:String = String(param1.target.data);
         if(_loc2_ != "")
         {
            _loc3_ = JSON.parse(_loc2_);
            if(_loc3_.hash != null)
            {
               _loc4_ = _loc2_.substr(10,_loc2_.length - 53);
               _loc5_ = String(MD5.hash(_loc4_ + Env.LEVEL_LIST_SALT));
               if(_loc3_.hash == _loc5_)
               {
                  this.showCourses(_loc3_.levels);
               }
            }
         }
         this.loadingGraphic.visible = false;
      }
      
      protected function errorHandler(param1:Event) : *
      {
         this.loadingGraphic.visible = false;
      }
      
      protected function requestCourses() : *
      {
         this.superLoader.load(new URLRequest(Main.levelsURL.substr(0,-7) + "/files/lists/" + this.mode + "/" + this.pageNum));
         this.loadingGraphic.visible = true;
      }
      
      public function getPageNum() : *
      {
         return this.pageNum;
      }
      
      public function setPageNum(param1:int) : *
      {
         this.pageNum = param1;
         Memory.memory["coursePageNum" + this.mode] = this.pageNum;
         this.removeLevels();
         this.requestCourses();
      }
      
      public function addPageHighlight(param1:Array) : *
      {
         if(this.mode !== "search" && this.mode !== "favorites")
         {
            this.pageNavigation.addPageHighlight(param1[0]);
         }
      }
      
      public function removePageHighlight(param1:Array) : *
      {
         if(this.mode !== "search" && this.mode !== "favorites")
         {
            this.pageNavigation.removePageHighlight(param1[0]);
         }
      }
      
      protected function testLevelAccess(param1:Event) : *
      {
         var _loc2_:String = null;
         for(_loc2_ in this.levels)
         {
            this.levels[_loc2_].testAccess();
         }
      }
      
      public function refreshHighlights() : *
      {
         Main.socket.write("refresh_highlights`");
      }
      
      protected function removeLevels() : *
      {
         var _loc1_:LevelItem = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.levelArray.length)
         {
            _loc1_ = this.levelArray[_loc2_];
            _loc1_.remove();
            _loc2_++;
         }
         this.levelArray = new Array();
         this.levels = new Object();
      }
      
      override public function remove() : *
      {
         removeEventListener("testLevelAccess",this.testLevelAccess);
         this.superLoader.removeEventListener(Event.COMPLETE,this.loadHandler);
         this.superLoader.remove();
         this.pageNavigation.remove();
         this.removeLevels();
         this.loadingGraphic = null;
         clearTimeout(this.var_280);
         super.remove();
      }
   }
}

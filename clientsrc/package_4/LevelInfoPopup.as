package package_4
{
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   import flash.events.*;
   import flash.net.*;
   import flash.ui.*;
   import flash.utils.*;
   import lobby.*;
   import package_18.PartInfo.*;
   import package_6.*;
   
   public class LevelInfoPopup extends Popup
   {
      
      public static var instance:*;
       
      
      public var superLoader:SuperLoader;
      
      public var m:LevelInfoPopupGraphic;
      
      public var htmlNameMaker:HTMLNameMaker;
      
      public var levelId:int = 0;
      
      public var live:Boolean = false;
      
      public var hasPass:Boolean = true;
      
      public var userId:int = 0;
      
      public var userName:String = "";
      
      public var userGroup:String = "0";
      
      public var title:String = "";
      
      public var note:String = "";
      
      public var version:int = 1;
      
      public var time:int = 0;
      
      public var updated:Date;
      
      public var plays:int = 0;
      
      public var rating:Number = 0;
      
      public var maxTime:int = 120;
      
      public var minRank:int = 0;
      
      public var gravity:Number = 1;
      
      public var items:String = "Laser Gun`Mine`Lightning`Teleport`Super Jump`Jet Pack`Speed Burst`Sword`Ice Wave";
      
      public var song:String = "";
      
      public var gameMode:String = "race";
      
      public var cowboyChance:int = 5;
      
      public var badHats:String = "";
      
      public var hoverUpdated:HoverPopup;
      
      public var hoverRating:HoverPopup;
      
      public var hoverGameMode:HoverPopup;
      
      public var hoverSong:HoverPopup;
      
      public var hoverCowboyChance:HoverPopup;
      
      public var hoverMaxTime:HoverPopup;
      
      public var hoverGravity:HoverPopup;
      
      public var hoverItems:InfoPopup;
      
      public var hoverHats:InfoPopup;
      
      public var hoverActionBt:HoverPopup;
      
      public var actionBtTimer:uint;
      
      public var actionType:String;
      
      public function LevelInfoPopup(param1:int)
      {
         this.m = new LevelInfoPopupGraphic();
         this.htmlNameMaker = new HTMLNameMaker();
         super();
         if(LevelInfoPopup.instance != null)
         {
            LevelInfoPopup.instance.startFadeOut();
         }
         LevelInfoPopup.instance = this;
         this.levelId = param1;
         this.m.levelInfo.visible = false;
         this.m.levelInfo.rating.buttonMode = this.m.levelInfo.gameMode.buttonMode = true;
         this.m.levelInfo.rating.cover.visible = this.m.levelInfo.gameMode.cover.visible = false;
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);
         addChild(this.m);
         this.superLoader = new SuperLoader(true,SuperLoader.j);
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.level_id = this.levelId;
         var _loc3_:URLRequest = new URLRequest(Main.levelsURL.substr(0,-7) + "/level_data.php");
         _loc3_.data = _loc2_;
         this.superLoader.load(_loc3_);
         this.superLoader.addEventListener(SuperLoader.d,this.applyReturnData,false,0,true);
         this.superLoader.addEventListener(SuperLoader.e,this.clickClose,false,0,true);
      }
      
      public function applyReturnData(param1:Event) : *
      {
         var _loc2_:Object = SuperLoader(param1.target).parsedData;
         this.live = _loc2_.live;
         this.hasPass = _loc2_.has_pass;
         this.userId = _loc2_.user_id;
         this.userName = _loc2_.user_name;
         this.userGroup = _loc2_.user_group;
         this.rating = _loc2_.rating;
         this.time = _loc2_.time;
         this.updated = new Date(this.time * 1000);
         this.gravity = _loc2_.gravity;
         this.maxTime = _loc2_.max_time;
         this.items = _loc2_.items;
         this.song = this.determineSong(_loc2_.song);
         this.gameMode = this.determineMode(_loc2_.gameMode);
         this.cowboyChance = _loc2_.cowboyChance;
         this.badHats = _loc2_.badHats;
         this.m.levelInfo.title.text = this.title = _loc2_.title;
         this.m.levelInfo.note.text = this.note = _loc2_.note;
         this.m.levelInfo.version.text = this.version = Data.formatNumber(_loc2_.version);
         this.m.levelInfo.plays.text = this.plays = Data.formatNumber(_loc2_.play_count);
         this.m.levelInfo.minRank.text = this.minRank = _loc2_.min_rank;
         this.m.levelInfo.author.htmlText = "by: " + this.htmlNameMaker.makeName(this.userName,this.userGroup);
         this.htmlNameMaker.listenForLink(this.m.levelInfo.author);
         this.m.levelInfo.updated.text = Data.getShortDateStr(this.time);
         this.m.levelInfo.rating.stars.bar.scaleX = this.rating / 5;
         this.m.levelInfo.updated.addEventListener(MouseEvent.MOUSE_OVER,this.overUpdatedHandler,false,0,true);
         this.m.levelInfo.updated.addEventListener(MouseEvent.MOUSE_OUT,this.outUpdatedHandler,false,0,true);
         this.m.levelInfo.rating.addEventListener(MouseEvent.MOUSE_OVER,this.overRatingHandler,false,0,true);
         this.m.levelInfo.rating.addEventListener(MouseEvent.MOUSE_OUT,this.outRatingHandler,false,0,true);
         this.m.levelInfo.gameMode.addEventListener(MouseEvent.MOUSE_OVER,this.overGameModeHandler,false,0,true);
         this.m.levelInfo.gameMode.addEventListener(MouseEvent.MOUSE_OUT,this.outGameModeHandler,false,0,true);
         this.m.levelInfo.song.addEventListener(MouseEvent.MOUSE_OVER,this.overSongHandler,false,0,true);
         this.m.levelInfo.song.addEventListener(MouseEvent.MOUSE_OUT,this.outSongHandler,false,0,true);
         this.m.levelInfo.cowboyChance.addEventListener(MouseEvent.MOUSE_OVER,this.overCowboyChanceHandler,false,0,true);
         this.m.levelInfo.cowboyChance.addEventListener(MouseEvent.MOUSE_OUT,this.outCowboyChanceHandler,false,0,true);
         this.m.levelInfo.maxTime.addEventListener(MouseEvent.MOUSE_OVER,this.overMaxTimeHandler,false,0,true);
         this.m.levelInfo.maxTime.addEventListener(MouseEvent.MOUSE_OUT,this.outMaxTimeHandler,false,0,true);
         this.m.levelInfo.gravity.addEventListener(MouseEvent.MOUSE_OVER,this.overGravityHandler,false,0,true);
         this.m.levelInfo.gravity.addEventListener(MouseEvent.MOUSE_OUT,this.outGravityHandler,false,0,true);
         this.m.levelInfo.items.addEventListener(MouseEvent.MOUSE_OVER,this.overItemsHandler,false,0,true);
         this.m.levelInfo.items.addEventListener(MouseEvent.MOUSE_OUT,this.outItemsHandler,false,0,true);
         this.m.levelInfo.hatsAllowed.addEventListener(MouseEvent.MOUSE_OVER,this.overHatsHandler,false,0,true);
         this.m.levelInfo.hatsAllowed.addEventListener(MouseEvent.MOUSE_OUT,this.outHatsHandler,false,0,true);
         this.m.play_bt.enabled = true;
         this.m.play_bt.addEventListener(MouseEvent.CLICK,this.clickPlay,false,0,true);
         if(Main.group >= 1)
         {
            this.m.levelInfo.share_bt.addEventListener(MouseEvent.MOUSE_OVER,this.overShareBt,false,0,true);
            this.m.levelInfo.share_bt.addEventListener(MouseEvent.MOUSE_OUT,this.outActionBt,false,0,true);
            this.m.levelInfo.share_bt.addEventListener(MouseEvent.CLICK,this.clickShare,false,0,true);
            if(Main.group >= 2)
            {
               this.m.levelInfo.removeChild(this.m.levelInfo.report_bt);
               this.m.levelInfo.unpublish_bt.addEventListener(MouseEvent.MOUSE_OVER,this.overActionBt,false,0,true);
               this.m.levelInfo.unpublish_bt.addEventListener(MouseEvent.MOUSE_OUT,this.outActionBt,false,0,true);
               this.m.levelInfo.unpublish_bt.addEventListener(MouseEvent.CLICK,this.clickRemove,false,0,true);
            }
            else if(Main.group == 1)
            {
               this.m.levelInfo.removeChild(this.m.levelInfo.unpublish_bt);
               this.m.levelInfo.report_bt.addEventListener(MouseEvent.MOUSE_OVER,this.overActionBt,false,0,true);
               this.m.levelInfo.report_bt.addEventListener(MouseEvent.MOUSE_OUT,this.outActionBt,false,0,true);
               this.m.levelInfo.report_bt.addEventListener(MouseEvent.CLICK,this.clickReport,false,0,true);
            }
         }
         else
         {
            this.m.levelInfo.removeChild(this.m.levelInfo.report_bt);
            this.m.levelInfo.removeChild(this.m.levelInfo.unpublish_bt);
            this.m.levelInfo.removeChild(this.m.levelInfo.share_bt);
         }
         this.m.loading.visible = false;
         this.m.levelInfo.visible = true;
      }
      
      public function overUpdatedHandler(param1:MouseEvent) : *
      {
         Mouse.cursor = MouseCursor.BUTTON;
         this.m.levelInfo.updated.textColor = 6710886;
         this.hoverUpdated = new HoverPopup("Last Updated","This level was last updated on " + Data.getDateTimeStr(this.time,["long","medium"]) + ".",this.m.levelInfo.updated);
         this.hoverUpdated.x += this.hoverUpdated.width * 1.5 + 10;
      }
      
      public function outUpdatedHandler(param1:*) : *
      {
         Mouse.cursor = MouseCursor.AUTO;
         this.m.levelInfo.updated.textColor = 0;
         this.hoverUpdated.remove();
         this.hoverUpdated = null;
      }
      
      public function overRatingHandler(param1:MouseEvent) : *
      {
         this.m.levelInfo.rating.cover.visible = true;
         this.hoverRating = new HoverPopup("",this.rating,this.m.levelInfo.rating);
         this.hoverRating.x += 238;
         this.hoverRating.y -= 15;
         this.hoverRating.width /= 2;
      }
      
      public function outRatingHandler(param1:*) : *
      {
         this.m.levelInfo.rating.cover.visible = false;
         this.hoverRating.remove();
         this.hoverRating = null;
      }
      
      public function overGameModeHandler(param1:MouseEvent) : *
      {
         this.m.levelInfo.gameMode.cover.visible = true;
         this.hoverGameMode = new HoverPopup("Game Mode",this.gameMode,this.m.levelInfo.gameMode);
      }
      
      public function outGameModeHandler(param1:*) : *
      {
         this.m.levelInfo.gameMode.cover.visible = false;
         this.hoverGameMode.remove();
         this.hoverGameMode = null;
      }
      
      public function overSongHandler(param1:MouseEvent) : *
      {
         this.hoverSong = new HoverPopup("Music",this.song,this.m.levelInfo.song);
         this.hoverSong.x += 193;
      }
      
      public function outSongHandler(param1:*) : *
      {
         this.hoverSong.remove();
         this.hoverSong = null;
      }
      
      public function overCowboyChanceHandler(param1:MouseEvent) : *
      {
         this.hoverCowboyChance = new HoverPopup("Chance of Cowboy Mode",this.cowboyChance + "%",this.m.levelInfo.cowboyChance);
      }
      
      public function outCowboyChanceHandler(param1:*) : *
      {
         this.hoverCowboyChance.remove();
         this.hoverCowboyChance = null;
      }
      
      public function overMaxTimeHandler(param1:MouseEvent) : *
      {
         this.hoverMaxTime = new HoverPopup("Time Limit",this.maxTime == 0 || this.maxTime == 999 && this.time < 1358640000 ? "Infinite" : Data.formatTime(this.maxTime) + " (" + Data.formatNumber(this.maxTime) + " seconds)",this.m.levelInfo.maxTime);
      }
      
      public function outMaxTimeHandler(param1:*) : *
      {
         this.hoverMaxTime.remove();
         this.hoverMaxTime = null;
      }
      
      public function overGravityHandler(param1:MouseEvent) : *
      {
         this.hoverGravity = new HoverPopup("Gravity Multiplier",this.gravity,this.m.levelInfo.gravity);
      }
      
      public function outGravityHandler(param1:*) : *
      {
         this.hoverGravity.remove();
         this.hoverGravity = null;
      }
      
      public function overItemsHandler(param1:MouseEvent) : *
      {
         this.hoverItems = new ItemMenu(this.items,this.m.levelInfo.items);
      }
      
      public function outItemsHandler(param1:*) : *
      {
         this.hoverItems.remove();
         this.hoverItems = null;
      }
      
      public function overHatsHandler(param1:MouseEvent) : *
      {
         this.hoverHats = new HatsMenu(this.badHats,this.gameMode,this.m.levelInfo.hatsAllowed);
      }
      
      public function outHatsHandler(param1:*) : *
      {
         this.hoverHats.remove();
         this.hoverHats = null;
      }
      
      public function determineMode(param1:String) : *
      {
         if(param1 == Modes.dm || param1 == "dm" || param1 == "d")
         {
            param1 = "Deathmatch";
            this.m.levelInfo.gameMode.modeSym.gotoAndStop(2);
         }
         else if(param1 == Modes.egg || param1 == "eggs" || param1 == "e")
         {
            param1 = "Alien Eggs";
            this.m.levelInfo.gameMode.modeSym.gotoAndStop(3);
         }
         else if(param1 == Modes.obj || param1 == "obj" || param1 == "o")
         {
            param1 = "Objective";
            this.m.levelInfo.gameMode.modeSym.gotoAndStop(4);
         }
         else if(param1 == Modes.hat || param1 == "h")
         {
            param1 = "Hat Attack";
            this.m.levelInfo.gameMode.modeSym.gotoAndStop(5);
         }
         else
         {
            param1 = "Race";
            this.m.levelInfo.gameMode.modeSym.gotoAndStop(1);
         }
         return param1;
      }
      
      public function determineSong(param1:String) : *
      {
         if(param1 == "" || param1 == "random")
         {
            return "Random";
         }
         if(param1 == "0" || param1 == "none")
         {
            return "None";
         }
         param1 = String(int(param1));
         var _loc2_:* = ["None","Orbital Trance - Space Planet","Code - Stefano Maccarelli","Paradise on E - API","Crying Soul (FL Mix) - Pyroific","My Vision - David Orr","Switchblade - Detective Jabsco","The Wires - Cheez-R-Us","Before Mydnite - F-777","","Broked It - SWiTCH","Hello? - TMM43","Pyrokinesis - Sean Tucker","Flowerz \'n\' Herbz - Brunzolaitis","Instrumental #4 - Reasoner","Prismatic - Lunanova","We Are Loud - Dynamedion","Toodaloo - mustangman","Night Shade - Goliathe","Blizzard! - Majicke","Pasture (Instrumental) - Dangevin","Sunset Raiders - AVL"];
         return _loc2_[param1];
      }
      
      public function overShareBt(param1:MouseEvent) : *
      {
         this.actionType = "share";
         this.actionBtTimer = setTimeout(this.showActionPopup,500);
      }
      
      public function overActionBt(param1:MouseEvent) : *
      {
         this.actionType = !!this.m.levelInfo.contains(this.m.levelInfo.report_bt) ? "report" : "unpublish";
         this.actionBtTimer = setTimeout(this.showActionPopup,500);
      }
      
      public function showActionPopup() : *
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         clearTimeout(this.actionBtTimer);
         var _loc3_:DisplayObject = this.m.levelInfo[this.actionType + "_bt"];
         if(this.actionType == "share")
         {
            _loc1_ = "Share Level";
            _loc2_ = "Send this level to another player. Or yourself. You control your own destiny.";
         }
         else if(this.actionType == "report")
         {
            _loc1_ = "Report Level";
            _loc2_ = "If this level is inappropriate, you can report it to the moderators.";
         }
         else if(this.actionType == "unpublish")
         {
            _loc1_ = "Moderate Level";
            _loc2_ = "Unpublish or restrict this level.";
         }
         this.hoverActionBt = new HoverPopup(_loc1_,_loc2_,_loc3_);
      }
      
      public function outActionBt(param1:MouseEvent) : *
      {
         this.actionType = null;
         clearTimeout(this.actionBtTimer);
         if(this.hoverActionBt != null)
         {
            this.hoverActionBt.remove();
            this.hoverActionBt = null;
         }
      }
      
      public function clickShare(param1:MouseEvent) : *
      {
         var _loc2_:* = "Hey, check out this level! \n\n[level=" + this.levelId + "]" + this.title + "[/level] by [user]" + this.userName + "[/user]";
         new SendMessagePopup("",_loc2_,false,true);
      }
      
      public function clickReport(param1:MouseEvent) : *
      {
         new LevelReportPopup(this.levelId,this.version);
      }
      
      public function clickRemove(param1:MouseEvent) : *
      {
         new ChooseLevelModModePopup(this.levelId);
      }
      
      public function clickPlay(param1:MouseEvent) : *
      {
         if(PartPopup.instance != null)
         {
            PartPopup.instance.startFadeOut();
         }
         if(PartInfoPopup.instance != null)
         {
            PartInfoPopup.instance.startFadeOut();
         }
         if(LobbyRight.lobbyRight != null)
         {
            LobbyRight.lobbyRight.lookupLevel(this.levelId);
         }
         startFadeOut();
      }
      
      public function clickClose(param1:*) : *
      {
         startFadeOut();
      }
      
      public function closeHoverPopups() : *
      {
         if(this.hoverUpdated != null)
         {
            this.outUpdatedHandler(dispatchEvent(new Event(Event.CLOSE)));
         }
         if(this.hoverRating != null)
         {
            this.outRatingHandler(dispatchEvent(new Event(Event.CLOSE)));
         }
         if(this.hoverGameMode != null)
         {
            this.outGameModeHandler(dispatchEvent(new Event(Event.CLOSE)));
         }
         if(this.hoverSong != null)
         {
            this.outSongHandler(dispatchEvent(new Event(Event.CLOSE)));
         }
         if(this.hoverCowboyChance != null)
         {
            this.outCowboyChanceHandler(dispatchEvent(new Event(Event.CLOSE)));
         }
         if(this.hoverMaxTime != null)
         {
            this.outMaxTimeHandler(dispatchEvent(new Event(Event.CLOSE)));
         }
         if(this.hoverGravity != null)
         {
            this.outGravityHandler(dispatchEvent(new Event(Event.CLOSE)));
         }
         if(this.hoverItems != null)
         {
            this.outItemsHandler(dispatchEvent(new Event(Event.CLOSE)));
         }
         if(this.hoverHats != null)
         {
            this.outHatsHandler(dispatchEvent(new Event(Event.CLOSE)));
         }
      }
      
      override public function remove() : *
      {
         if(LevelInfoPopup.instance === this)
         {
            LevelInfoPopup.instance = null;
         }
         this.closeHoverPopups();
         this.m.levelInfo.updated.removeEventListener(MouseEvent.MOUSE_OVER,this.overUpdatedHandler);
         this.m.levelInfo.updated.removeEventListener(MouseEvent.MOUSE_OUT,this.outUpdatedHandler);
         this.m.levelInfo.rating.removeEventListener(MouseEvent.MOUSE_OVER,this.overRatingHandler);
         this.m.levelInfo.rating.removeEventListener(MouseEvent.MOUSE_OUT,this.outRatingHandler);
         this.m.levelInfo.gameMode.removeEventListener(MouseEvent.MOUSE_OVER,this.overGameModeHandler);
         this.m.levelInfo.gameMode.removeEventListener(MouseEvent.MOUSE_OUT,this.outGameModeHandler);
         this.m.levelInfo.song.removeEventListener(MouseEvent.MOUSE_OVER,this.overSongHandler);
         this.m.levelInfo.song.removeEventListener(MouseEvent.MOUSE_OUT,this.outSongHandler);
         this.m.levelInfo.cowboyChance.removeEventListener(MouseEvent.MOUSE_OVER,this.overCowboyChanceHandler);
         this.m.levelInfo.cowboyChance.removeEventListener(MouseEvent.MOUSE_OUT,this.outCowboyChanceHandler);
         this.m.levelInfo.maxTime.removeEventListener(MouseEvent.MOUSE_OVER,this.overMaxTimeHandler);
         this.m.levelInfo.maxTime.removeEventListener(MouseEvent.MOUSE_OUT,this.outMaxTimeHandler);
         this.m.levelInfo.gravity.removeEventListener(MouseEvent.MOUSE_OVER,this.overGravityHandler);
         this.m.levelInfo.gravity.removeEventListener(MouseEvent.MOUSE_OUT,this.outGravityHandler);
         this.m.levelInfo.items.removeEventListener(MouseEvent.MOUSE_OVER,this.overItemsHandler);
         this.m.levelInfo.items.removeEventListener(MouseEvent.MOUSE_OUT,this.outItemsHandler);
         this.m.levelInfo.hatsAllowed.removeEventListener(MouseEvent.MOUSE_OVER,this.overHatsHandler);
         this.m.levelInfo.hatsAllowed.removeEventListener(MouseEvent.MOUSE_OUT,this.outHatsHandler);
         this.m.play_bt.removeEventListener(MouseEvent.CLICK,this.clickPlay);
         this.m.levelInfo.unpublish_bt.addEventListener(MouseEvent.MOUSE_OVER,this.overActionBt);
         this.m.levelInfo.unpublish_bt.addEventListener(MouseEvent.MOUSE_OUT,this.outActionBt);
         this.m.levelInfo.unpublish_bt.removeEventListener(MouseEvent.CLICK,this.clickRemove);
         this.m.levelInfo.report_bt.addEventListener(MouseEvent.MOUSE_OVER,this.overActionBt);
         this.m.levelInfo.report_bt.addEventListener(MouseEvent.MOUSE_OUT,this.outActionBt);
         this.m.levelInfo.report_bt.removeEventListener(MouseEvent.CLICK,this.clickReport);
         this.m.levelInfo.share_bt.addEventListener(MouseEvent.MOUSE_OVER,this.overShareBt);
         this.m.levelInfo.share_bt.addEventListener(MouseEvent.MOUSE_OUT,this.outActionBt);
         this.m.levelInfo.share_bt.removeEventListener(MouseEvent.CLICK,this.clickShare);
         clearTimeout(this.actionBtTimer);
         if(this.hoverActionBt != null)
         {
            this.hoverActionBt.remove();
            this.hoverActionBt = null;
         }
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
         if(this.superLoader != null)
         {
            this.superLoader.removeEventListener(SuperLoader.d,this.applyReturnData);
            this.superLoader.removeEventListener(SuperLoader.e,this.clickClose);
            this.superLoader.remove();
            this.superLoader = null;
         }
         this.htmlNameMaker.remove();
         this.htmlNameMaker = null;
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}

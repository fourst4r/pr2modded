package package_6
{
   import com.adobe.crypto.*;
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.geom.Point;
   import flash.net.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import package_4.*;
   import package_8.*;
   import package_9.*;
   import sounds.*;
   
   public class Game extends Course
   {
       
      
      public var superLoader:SuperLoader;
      
      public var quitButton:QuitButton;
      
      public var cm:CommandHandler;
      
      public var spectatePicker:SpectatePicker;
      
      public var drawingInfo:DrawingInfo;
      
      public var prize:Object;
      
      public var luxPop:LuxPopup;
      
      public var levelHash:String = "";
      
      public var specialEvent:SpecialEvent;
      
      public var var_634:Array;
      
      public var var_202:FinishedPage;
      
      public var var_463:Array;
      
      public var var_452:int;
      
      public var var_465:int;
      
      public var var_347:int;
      
      public var hatCountdown:uint;
      
      public function Game(param1:int, param2:int)
      {
         this.superLoader = new SuperLoader(false);
         this.cm = CommandHandler.commandHandler;
         this.var_634 = new Array();
         this.var_463 = new Array();
         super();
         this.courseID = param1;
         this.version = param2;
         this.quitButton = new QuitButton(this);
         this.specialEvent = new SpecialEvent(Main.stage,this);
         Egg.method_333(0);
      }
      
      override public function initialize() : *
      {
         this.chatBox = new RaceChat();
         this.chatBox.x = -271;
         this.chatBox.y = 49;
         holder.addChild(this.chatBox);
         this.drawingInfo = new DrawingInfo();
         this.drawingInfo.x = -273;
         this.drawingInfo.y = -104;
         holder.addChild(this.drawingInfo);
         holder.addChild(this.quitButton);
         this.cm.defineCommand("createRemoteCharacter",this.createRemoteCharacter);
         this.cm.defineCommand("createLocalCharacter",this.createLocalCharacter);
         this.cm.defineCommand("award",this.award);
         this.cm.defineCommand("setExpGain",this.setExpGain);
         this.cm.defineCommand("setLuxGain",this.setLuxGain);
         this.cm.defineCommand("setPrize",this.setPrize);
         this.cm.defineCommand("cancelPrize",this.cancelPrize);
         this.cm.defineCommand("winPrize",this.winPrize);
         this.cm.defineCommand("cowboyMode",this.cowboyMode);
         this.cm.defineCommand("happyHour",this.happyHour);
         this.cm.defineCommand("setEggSeed",setEggSeed);
         this.cm.defineCommand("addEggs",addEggs);
         this.cm.defineCommand("superBooster",this.superBooster);
         this.cm.defineCommand("maybeReturnHatToStart",this.maybeReturnHatToStart);
         this.cm.defineCommand("startHatCountdown",this.startHatCountdown);
         this.cm.defineCommand("forceQuit",this.quitGame);
         super.initialize();
         this.getLevelData();
      }
      
      public function initSpectate() : *
      {
         this.spectatePicker = new SpectatePicker();
         this.spectatePicker.x = -265;
         this.spectatePicker.y = 30;
         this.spectatePicker.scaleX = this.spectatePicker.scaleY = 0.9;
         holder.addChild(this.spectatePicker);
         this.toggleSpectatePossible(true);
      }
      
      override public function toggleSpectatePossible(param1:Boolean) : *
      {
         super.changeSpectate(-1);
         this.spectatePicker.toggleVisibility(param1);
         super.toggleSpectatePossible(param1);
      }
      
      override public function onSpectateKeyPress(param1:Event) : *
      {
         if(!(Main.stage.focus is TextField) && (Keys.isPressed(Keyboard.DOWN) || Keys.isPressed(altCtrl.down) || Keys.isPressed(Keyboard.UP) || Keys.isPressed(altCtrl.up) || Keys.isPressed(Keyboard.LEFT) || Keys.isPressed(altCtrl.left) || Keys.isPressed(Keyboard.RIGHT) || Keys.isPressed(altCtrl.right)))
         {
            this.spectatePicker.stopSpectating();
            super.onSpectateKeyPress(param1);
         }
      }
      
      override public function onCountdownFinish(param1:Event) : *
      {
         if(PrizePopup.instance != null)
         {
            PrizePopup.instance.startFadeOut();
         }
         super.onCountdownFinish(param1);
      }
      
      public function getLevelData() : *
      {
         var _loc1_:URLRequest = new URLRequest(Main.levelsURL + "/" + courseID + ".txt?version=" + version);
         this.superLoader.addEventListener(Event.COMPLETE,this.loadHandler,false,0,true);
         this.superLoader.load(_loc1_);
      }
      
      public function loadHandler(param1:Event) : *
      {
         var _loc7_:URLVariables = null;
         this.superLoader.removeEventListener(Event.COMPLETE,this.loadHandler);
         var _loc2_:String = String(param1.target.data);
         var _loc3_:int = _loc2_.length - 32;
         var _loc4_:String = _loc2_.substr(_loc3_);
         var _loc5_:String = _loc2_.substr(0,_loc3_);
         var _loc6_:String;
         if((_loc6_ = String(MD5.hash(version.toString() + courseID.toString() + _loc5_ + Env.LEVEL_SALT_2))) != _loc4_)
         {
            new MessagePopup("Error: The course did not download correctly.");
         }
         else if(_loc5_ == "")
         {
            new MessagePopup("Error: The course did not load.");
         }
         else
         {
            this.superLoader.remove();
            this.superLoader = null;
            _loc5_ = validateSaveString(_loc5_);
            this.levelHash = MD5.hash(_loc5_ + courseID + version + Env.LEVEL_HASH_SALT);
            _loc7_ = new URLVariables(_loc5_);
            setVariables(_loc7_);
            this.initSpectate();
         }
      }
      
      override public function beginRace(param1:Array) : *
      {
         this.drawingInfo.clear();
         super.beginRace(param1);
      }
      
      public function award(param1:Array) : *
      {
         this.var_463.push(param1);
         if(this.var_202 != null)
         {
            this.var_202.award(param1);
         }
      }
      
      public function setExpGain(param1:Array) : *
      {
         this.var_452 = int(param1[0]);
         this.var_465 = int(param1[1]);
         this.var_347 = int(param1[2]);
         this.finish();
         this.method_196();
         if(this.var_202 != null)
         {
            this.var_202.setExpGain(this.var_452,this.var_465,this.var_347);
         }
      }
      
      public function setLuxGain(param1:Array) : *
      {
         this.luxPop = new LuxPopup(int(param1[0]));
      }
      
      public function setPrize(param1:Array) : *
      {
         this.prize = JSON.parse(param1[0]);
         new PrizePopup(this.prize.type,this.prize.id,this.prize.name,this.prize.desc,this.prize.universal,false);
      }
      
      public function cancelPrize(param1:Array) : *
      {
         this.prize = null;
         new PrizePopup("cancel",0,"Prize Cancelled",param1[0]);
      }
      
      public function winPrize(param1:Array) : *
      {
         this.prize = JSON.parse(param1[0]);
         new PrizePopup(this.prize.type,this.prize.id,this.prize.name,this.prize.desc,this.prize.universal,true);
         if(Main.instance.kongAPI != null && this.prize.type == "hat")
         {
            Main.instance.kongAPI.stats.submit(this.prize.name,1);
         }
      }
      
      public function cowboyMode(param1:Array) : *
      {
         addChild(new CowboyMode());
      }
      
      public function happyHour(param1:Array) : *
      {
         addChild(new HappyHour());
      }
      
      public function superBooster(param1:Array) : *
      {
         var _loc2_:int = int(param1[0]);
         var _loc3_:Character = playerArray[_loc2_];
         _loc3_.method_576();
      }
      
      public function maybeReturnHatToStart(param1:Array) : *
      {
         var _loc3_:Point = null;
         var _loc4_:int = 0;
         var _loc2_:Hat = looseHats[int(param1[0])];
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getPos();
            _loc4_ = _loc2_.getRot();
            _loc3_ = Data.method_9(_loc3_.x,_loc3_.y,_loc4_);
            if(_loc3_.y > blockBackground.maxY + 500 && _loc4_ == 0 || _loc3_.y < blockBackground.minY - 500 && Math.abs(_loc4_) == 180 || _loc3_.x > blockBackground.maxX + 500 && _loc4_ == 90 || _loc3_.x < blockBackground.minX - 500 && _loc4_ == -90)
            {
               this.returnHatToStart(_loc2_);
            }
         }
      }
      
      public function returnHatToStart(param1:Hat) : *
      {
         var _loc2_:Object = param1.getInfo();
         param1.remove();
         if(_loc2_.id < startPosArray.length)
         {
            new Hat(startPosArray[_loc2_.id].x,startPosArray[_loc2_.id].y,0,_loc2_.num,_loc2_.color,_loc2_.color2,_loc2_.id);
         }
      }
      
      public function startHatCountdown(param1:Array = null) : *
      {
         this.cm.defineCommand("cancelHatCountdown",this.cancelHatCountdown);
         this.hatCountdown = setInterval(this.checkHatCountdown,1000);
      }
      
      public function checkHatCountdown() : *
      {
         Main.socket.write("check_hat_countdown`");
      }
      
      public function cancelHatCountdown(param1:Array = null) : *
      {
         this.cm.defineCommand("cancelHatCountdown",null);
         clearInterval(this.hatCountdown);
      }
      
      public function createRemoteCharacter(param1:Array) : *
      {
         var _loc2_:int = int(param1[0]);
         var _loc3_:String = String(param1[1]);
         var _loc4_:Number = Number(param1[2]);
         var _loc5_:Number = Number(param1[3]);
         var _loc6_:Number = Number(param1[4]);
         var _loc7_:Number = Number(param1[5]);
         var _loc8_:Number = Number(param1[6]);
         var _loc9_:Number = Number(param1[7]);
         var _loc10_:Number = Number(param1[8]);
         var _loc11_:Number = Number(param1[9]);
         var _loc12_:Number = Number(param1[10]);
         var _loc13_:Number = Number(param1[11]);
         var _loc14_:Number = Number(param1[12]);
         var _loc15_:Number = Number(param1[13]);
         var _loc16_:String = String(param1[14]);
         var _loc17_:RemoteCharacter;
         (_loc17_ = new RemoteCharacter(_loc2_,miniMap.getDot(),_loc3_,_loc8_,_loc9_,_loc10_,_loc11_,_loc16_)).setColors(_loc4_,_loc12_,_loc5_,_loc13_,_loc6_,_loc14_,_loc7_,_loc15_);
         playerArray[_loc2_] = _loc17_;
         this.drawingInfo.method_138(_loc3_,_loc2_);
         positionPlayersAtStart();
      }
      
      public function createLocalCharacter(param1:Array) : *
      {
         var _loc2_:int = int(param1[0]);
         var _loc3_:Number = Number(param1[1]);
         var _loc4_:Number = Number(param1[2]);
         var _loc5_:Number = Number(param1[3]);
         var _loc6_:Number = Number(param1[4]);
         var _loc7_:Number = Number(param1[5]);
         var _loc8_:Number = Number(param1[6]);
         var _loc9_:Number = Number(param1[7]);
         var _loc10_:Number = Number(param1[8]);
         var _loc11_:Number = Number(param1[9]);
         var _loc12_:Number = Number(param1[10]);
         var _loc13_:Number = Number(param1[11]);
         var _loc14_:Number = Number(param1[12]);
         var _loc15_:Number = Number(param1[13]);
         var _loc16_:Number = Number(param1[14]);
         var _loc17_:Number = Number(param1[15]);
         var _loc18_:String = String(param1[16]);
         var _loc19_:LocalCharacter;
         (_loc19_ = new LocalCharacter(_loc2_,this,blockBackground,miniMap.getDot(),itemDisplay,Number(gravity),_loc3_,_loc4_,_loc5_,_loc10_,_loc11_,_loc12_,_loc13_,_loc18_)).setColors(_loc6_,_loc14_,_loc7_,_loc15_,_loc8_,_loc16_,_loc9_,_loc17_);
         playerArray[_loc2_] = _loc19_;
         this.drawingInfo.method_138(Main.loggedInAs,_loc2_);
         var_9 = _loc19_;
         positionPlayersAtStart();
      }
      
      override public function collectEgg(param1:int) : *
      {
         if(this.gameMode == "egg")
         {
            Main.socket.write("grab_egg`" + param1);
         }
      }
      
      public function method_196() : *
      {
         if(this.var_202 == null)
         {
            this.method_185();
            this.quitButton.stopGlow();
            this.var_202 = new FinishedPage(this);
         }
      }
      
      override public function endIntro() : *
      {
         Main.socket.write("finish_drawing`" + this.levelHash + "`" + this.gameMode + "`" + this.getFinishBlockPositions() + "`" + finishBlocks.length + "`" + cowboyChance + "`" + badHats.join(","));
         super.endIntro();
      }
      
      public function getFinishBlockPositions() : String
      {
         return finishBlocks.length > 5 ? "all" : JSON.stringify(finishBlocks);
      }
      
      override public function outOfTimeHandler() : *
      {
         this.cancelHatCountdown();
         if(this.gameMode == Modes.egg)
         {
            this.finish();
            this.method_196();
         }
         else
         {
            this.quitGame();
         }
      }
      
      override public function finish(param1:int = -1, param2:int = 0, param3:int = 0) : *
      {
         if(!playerDone)
         {
            if(this.gameMode == Modes.obj)
            {
               if(param1 != -1)
               {
                  miniMap.removeFinish(param2,param3);
                  Main.socket.write("objective_reached`" + param1 + "`" + param2 + "`" + param3);
               }
            }
            else
            {
               Main.socket.write("finish_race`" + param1 + "`" + param2 + "`" + param3);
               if(this.gameMode != Modes.hat)
               {
                  this.quitButton.startGlow();
                  this.method_185();
                  this.method_682();
                  timer.pause();
               }
            }
            SoundEffects.playSound(new VictorySound(),1 * (Settings.soundLevel / 100));
         }
      }
      
      public function quitGame(param1:Array = null) : *
      {
         if(!playerDone)
         {
            if(this.gameMode == Modes.dm)
            {
               this.finish();
            }
            else
            {
               Main.socket.write("quit_race`");
            }
         }
         this.method_185();
         this.method_196();
      }
      
      public function method_682() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(var_9 != null)
         {
            _loc1_ = 1;
            while(_loc1_ <= 4)
            {
               if(var_9["hat" + _loc1_] <= 1)
               {
                  break;
               }
               _loc1_++;
            }
            _loc2_ = _loc1_ - 1;
            if(Main.instance.kongAPI != null)
            {
               Main.instance.kongAPI.stats.submit("Hat Finish",_loc2_);
            }
         }
      }
      
      public function method_185() : *
      {
         if(!playerDone)
         {
            playerDone = true;
            if(var_9 != null)
            {
               var_9.beginRemove();
            }
            this.toggleSpectatePossible(true);
            super.toggleKeyScroll(true);
            Main.stage.focus = Main.stage;
         }
      }
      
      public function isDonePlaying() : Boolean
      {
         return playerDone;
      }
      
      override public function remove() : *
      {
         this.cm.defineCommand("createRemoteCharacter",null);
         this.cm.defineCommand("createLocalCharacter",null);
         this.cm.defineCommand("award",null);
         this.cm.defineCommand("setExpGain",null);
         this.cm.defineCommand("setLuxGain",null);
         this.cm.defineCommand("setPrize",null);
         this.cm.defineCommand("cancelPrize",null);
         this.cm.defineCommand("winPrize",null);
         this.cm.defineCommand("cowboyMode",null);
         this.cm.defineCommand("setEggSeed",null);
         this.cm.defineCommand("addEggs",null);
         this.cm.defineCommand("superBooster",null);
         this.cm.defineCommand("maybeReturnHatToStart",null);
         this.cm.defineCommand("startHatCountdown",null);
         this.cm.defineCommand("forceQuit",null);
         removeEventListener(Event.ENTER_FRAME,maybeEndIntro);
         removeEventListener(Event.ENTER_FRAME,cameraFollowPlayer);
         removeEventListener(Event.ENTER_FRAME,keyScroll);
         if(this.drawingInfo != null)
         {
            this.drawingInfo.remove();
            this.drawingInfo = null;
         }
         if(this.spectatePicker != null)
         {
            this.spectatePicker.remove();
            this.spectatePicker = null;
         }
         if(this.superLoader != null)
         {
            this.superLoader.removeEventListener(Event.COMPLETE,this.loadHandler);
            this.superLoader.remove();
            this.superLoader = null;
         }
         this.prize = null;
         if(PrizePopup.instance !== null)
         {
            PrizePopup.instance.startFadeOut();
         }
         if(PlaceArtifact.instance !== null)
         {
            PlaceArtifact.instance.startFadeOut();
         }
         if(this.luxPop != null)
         {
            this.luxPop.remove();
            this.luxPop = null;
         }
         this.quitButton.remove();
         this.chatBox.remove();
         this.specialEvent.remove();
         this.specialEvent = null;
         this.cancelHatCountdown();
         super.remove();
      }
   }
}

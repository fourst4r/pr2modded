package package_6
{
   import blocks.*;
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.URLVariables;
   import levelEditor.*;
   import package_8.*;
   import package_9.*;
   import sounds.*;
   import ui.*;
   
   public class TestCourse extends Course
   {
       
      
      public var m:TestCourseGraphic;
      
      public var variables:URLVariables;
      
      public var isMod:Boolean = false;
      
      public var reportsMode:Boolean = false;
      
      public var statsSelect:StatsSelect;
      
      public var hatPicker:HatPicker;
      
      public function TestCourse(param1:URLVariables, param2:Boolean = false, param3:Boolean = false)
      {
         this.m = new TestCourseGraphic();
         super();
         this.variables = param1;
         this.isMod = param2;
         this.reportsMode = param3;
      }
      
      override public function initialize() : *
      {
         var _loc2_:Point = null;
         super.initialize();
         setVariables(this.variables);
         this.m.back_bt.addEventListener(MouseEvent.CLICK,this.clickBack);
         this.m.restart_bt.addEventListener(MouseEvent.CLICK,this.clickRestart);
         holder.addChild(this.m);
         musicSelection.x = -130;
         var _loc1_:Object = Settings.getValue(Settings.LE_TEST_STATS,Settings.DEFAULT_LE_TEST_STATS);
         var_9 = new LocalCharacter(0,this,blockBackground,miniMap.getDot(),itemDisplay,this.variables.gravity,_loc1_.speed,_loc1_.acceleration,_loc1_.jumping);
         var_9.setColors(16777215,-1,16777215,-1,16777215,-1,16777215,-1);
         var_9.testMode = true;
         playerArray.push(var_9);
         this.statsSelect = new StatsSelect(300,_loc1_.speed,_loc1_.acceleration,_loc1_.jumping,var_9);
         this.statsSelect.x = -265;
         this.statsSelect.y = 90;
         this.statsSelect.scaleX = this.statsSelect.scaleY = 0.66;
         holder.addChild(this.statsSelect);
         this.hatPicker = new HatPicker(var_9);
         this.hatPicker.x = -260;
         this.hatPicker.y = 65;
         this.hatPicker.scaleX = this.hatPicker.scaleY = 0.7;
         holder.addChild(this.hatPicker);
         _loc2_ = startPosArray[0];
         var_9.setPos(_loc2_.x,_loc2_.y);
         posX = -_loc2_.x;
         posY = -_loc2_.y;
         setPos(posX,posY);
         frontBackground.addChild(var_9);
         addEventListener(Event.ENTER_FRAME,this.go);
         var_14.addEventListener(MouseEvent.CLICK,this.teleportToClickPos,false,0,true);
         if(gameMode == Modes.egg)
         {
            setEggSeed([Math.floor(Math.random() * 9999).toString()]);
            addEggs([10]);
         }
      }
      
      override public function collectEgg(param1:int) : *
      {
         addEggs([1]);
      }
      
      public function go(param1:Event) : *
      {
         Main.stage.focus = Main.stage;
      }
      
      override public function endIntro() : *
      {
         super.endIntro();
         beginRace(new Array());
      }
      
      public function clickBack(param1:MouseEvent) : *
      {
         Main.pageHolder.changePage(new LevelEditor(this.variables,this.isMod,this.reportsMode));
      }
      
      public function clickRestart(param1:MouseEvent) : *
      {
         this.restart();
      }
      
      override public function finish(param1:int = -1, param2:int = 0, param3:int = 0) : *
      {
         if(this.gameMode != Modes.obj)
         {
            this.restart();
         }
         else
         {
            miniMap.removeFinish(param2,param3);
         }
         SoundEffects.playSound(new VictorySound(),1 * (Settings.soundLevel / 100));
      }
      
      public function teleportToClickPos(param1:MouseEvent) : *
      {
         var _loc2_:Point = var_14.globalToLocal(new Point(param1.stageX,param1.stageY));
         var _loc3_:int = -frontBackground.x + _loc2_.x;
         var _loc4_:int = -frontBackground.y + _loc2_.y;
         new TeleportPop(var_9.x,var_9.y);
         var_9.setPos(_loc3_,_loc4_);
         new TeleportPop(var_9.x,var_9.y);
      }
      
      public function statsSelectSetFromCharacter() : *
      {
         this.statsSelect.setStatsFromCharacter();
      }
      
      public function restart() : *
      {
         Main.stage.focus = Main.stage;
         TeleportBlock.resetAll();
         blockBackground.rotation = bg1.rotation = bg2.rotation = bg3.rotation = bg4.rotation = bg5.rotation = 0;
         timer.setTime(Number(maxTime));
         effectBackground.clear();
         blockBackground.clear();
         miniMap.clear();
         blockBackground.draw();
         blockBackground.method_578();
         var _loc1_:Point = startPosArray[0];
         var_9.setPos(_loc1_.x,_loc1_.y);
         var_9.setItem(0);
         var_9.setLife(3);
         this.hatPicker.resetHat();
         var _loc2_:Object = Settings.getValue(Settings.LE_TEST_STATS,Settings.DEFAULT_LE_TEST_STATS);
         var_9.setStats(_loc2_.speed,_loc2_.acceleration,_loc2_.jumping);
         this.statsSelectSetFromCharacter();
         miniMap.rotate(0);
      }
      
      override public function remove() : *
      {
         blockBackground.clearMoveInterval();
         TeleportBlock.resetAll();
         var_14.removeEventListener(MouseEvent.CLICK,this.teleportToClickPos);
         removeEventListener(Event.ENTER_FRAME,this.go);
         this.m.back_bt.removeEventListener(MouseEvent.CLICK,this.clickBack);
         this.m.restart_bt.removeEventListener(MouseEvent.CLICK,this.clickRestart);
         this.statsSelect.remove();
         this.hatPicker.remove();
         this.hatPicker = null;
         this.m = null;
         this.statsSelect = null;
         this.variables = null;
         super.remove();
      }
   }
}

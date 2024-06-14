package levelEditor
{
   import background.*;
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.Point;
   import flash.net.*;
   import page.GamePage;
   
   public class LevelEditor extends GamePage
   {
      
      public static var segSize:Number = 30;
      
      public static var editor:LevelEditor;
       
      
      protected var drawingPop:DrawingPopup;
      
      public var var_364:Sprite;
      
      public var menu:LevelEditorMenu;
      
      public var var_225:Background;
      
      public var cur:ObjectBackground;
      
      public var var_220:DrawableBackground;
      
      public var bg1:ObjectBackground;
      
      public var bg2:ObjectBackground;
      
      public var bg3:ObjectBackground;
      
      public var bg4:ObjectBackground;
      
      public var bg5:ObjectBackground;
      
      public var draw1:DrawableBackground;
      
      public var draw2:DrawableBackground;
      
      public var draw3:DrawableBackground;
      
      public var draw4:DrawableBackground;
      
      public var draw5:DrawableBackground;
      
      public var bg:class_10;
      
      public var blockBG:BlockBackground;
      
      public var blockGrid:BlockGridLines;
      
      public var live:Number = 0;
      
      public var minRank:String = "0";
      
      public var pass:String = null;
      
      public var hasPass:int = 0;
      
      public var toNewest:Boolean = true;
      
      protected var variables:URLVariables;
      
      protected var isMod:Boolean = false;
      
      protected var reportsMode:Boolean = false;
      
      public function LevelEditor(param1:URLVariables, param2:Boolean = false, param3:Boolean = false)
      {
         super();
         this.variables = param1;
         this.isMod = param2;
         this.reportsMode = param3;
      }
      
      override public function initialize() : *
      {
         super.initialize();
         LevelEditor.editor = this;
         Main.stage.quality = StageQuality.HIGH;
         this.var_364 = new Sprite();
         this.var_364.mouseEnabled = false;
         this.var_364.mouseChildren = false;
         this.menu = new LevelEditorMenu();
         this.menu.init();
         this.attachBackgrounds();
         addChild(this.menu);
         this.menu.setReportsMode(this.reportsMode);
         addChild(this.var_364);
         if(this.variables != null)
         {
            this.setVariables(this.variables);
            this.variables = null;
         }
         addEventListener(Event.ENTER_FRAME,this.keyScroll);
      }
      
      override protected function keyScroll(param1:Event) : *
      {
         super.keyScroll(param1);
         var _loc2_:Number = 275 * (1 / scaleX);
         var _loc3_:Number = 200 * (1 / scaleY);
         posX = Data.numLimit(posX,-var_239 + _loc2_,-_loc2_);
         posY = Data.numLimit(posY,-var_362 + _loc3_,-_loc3_);
         this.setPos(posX,posY);
      }
      
      override protected function attachBackgrounds() : *
      {
         this.bg1 = new ObjectBackground(this);
         this.bg2 = new ObjectBackground(this);
         this.bg3 = new ObjectBackground(this);
         this.bg4 = new ObjectBackground(this);
         this.bg5 = new ObjectBackground(this);
         this.draw1 = new DrawableBackground(this);
         this.draw2 = new DrawableBackground(this);
         this.draw3 = new DrawableBackground(this);
         this.draw4 = new DrawableBackground(this);
         this.draw5 = new DrawableBackground(this);
         this.bg = new class_10(this);
         this.blockGrid = new BlockGridLines(this);
         this.blockBG = new BlockBackground(this);
         this.bg1.setScale(1);
         this.draw1.setScale(1);
         this.bg2.setScale(0.5);
         this.draw2.setScale(0.5);
         this.bg3.setScale(0.25);
         this.draw3.setScale(0.25);
         this.bg4.setScale(1);
         this.draw4.setScale(1);
         this.bg5.setScale(2);
         this.draw5.setScale(2);
         var_14.addChild(this.bg);
         var_14.addChild(this.draw3);
         var_14.addChild(this.bg3);
         var_14.addChild(this.draw2);
         var_14.addChild(this.bg2);
         var_14.addChild(this.draw1);
         var_14.addChild(this.bg1);
         var_14.addChild(this.blockGrid);
         var_14.addChild(this.blockBG);
         var_14.addChild(this.bg4);
         var_14.addChild(this.draw4);
         var_14.addChild(this.bg5);
         var_14.addChild(this.draw5);
         this.cur = this.blockBG;
         this.var_220 = this.draw1;
         this.var_225 = this.cur;
         this.blockGrid.mouseEnabled = false;
         this.blockGrid.mouseChildren = false;
         this.setStartPos();
         this.setZoom(zoom);
         this.setColor(12303325);
         this.focusOn(this.blockBG);
         this.menu.reset();
      }
      
      override protected function removeBackgrounds() : *
      {
         this.bg1.remove();
         this.bg2.remove();
         this.bg3.remove();
         this.bg4.remove();
         this.bg5.remove();
         this.draw1.remove();
         this.draw2.remove();
         this.draw3.remove();
         this.draw4.remove();
         this.draw5.remove();
         this.bg.remove();
         this.blockBG.remove();
         this.blockGrid.remove();
         this.bg1 = null;
         this.bg2 = null;
         this.bg3 = null;
         this.bg4 = null;
         this.bg5 = null;
         this.draw1 = null;
         this.draw2 = null;
         this.draw3 = null;
         this.draw4 = null;
         this.draw5 = null;
      }
      
      override public function setPos(param1:Number, param2:Number) : *
      {
         this.blockBG.setPos(param1,param2);
         this.bg1.setPos(param1,param2);
         this.bg2.setPos(param1,param2);
         this.bg3.setPos(param1,param2);
         this.bg4.setPos(param1,param2);
         this.bg5.setPos(param1,param2);
         this.draw1.setPos(param1,param2);
         this.draw2.setPos(param1,param2);
         this.draw3.setPos(param1,param2);
         this.draw4.setPos(param1,param2);
         this.draw5.setPos(param1,param2);
         this.blockGrid.setPos(param1,param2);
      }
      
      override public function setColor(param1:Number = 0) : *
      {
         this.bg1.setColor(param1);
         this.bg2.setColor(param1);
         this.bg3.setColor(param1);
         this.bg4.setColor(param1);
         this.bg5.setColor(param1);
         this.draw1.setColor(param1);
         this.draw2.setColor(param1);
         this.draw3.setColor(param1);
         this.draw4.setColor(param1);
         this.draw5.setColor(param1);
         this.bg.setColor(param1);
         super.setColor(param1);
      }
      
      override public function setSaveString(param1:String) : *
      {
         var _loc2_:Array = param1.split("`");
         this.setColor(Number(_loc2_[0]));
         this.menu.bg.cp_btn.updateColor();
         this.blockBG.setSaveString(_loc2_[1]);
         this.bg1.setSaveString(_loc2_[2]);
         this.bg2.setSaveString(_loc2_[3]);
         this.bg3.setSaveString(_loc2_[4]);
         this.bg4.setSaveString(_loc2_[9]);
         this.bg5.setSaveString(_loc2_[10]);
         this.draw1.setSaveString(_loc2_[5]);
         this.draw2.setSaveString(_loc2_[6]);
         this.draw3.setSaveString(_loc2_[7]);
         this.draw4.setSaveString(_loc2_[11]);
         this.draw5.setSaveString(_loc2_[12]);
         this.bg.setSaveString(_loc2_[8]);
         this.focusOn(this.var_225);
         this.setStartPos();
      }
      
      override public function startDrawing(param1:Background) : *
      {
         super.startDrawing(param1);
         if(this.drawingPop == null)
         {
            this.drawingPop = new DrawingPopup();
         }
      }
      
      override public function finishDrawing(param1:Background) : *
      {
         super.finishDrawing(param1);
         if(var_133.length <= 0 && this.drawingPop != null)
         {
            this.drawingPop.startFadeOut();
            this.drawingPop = null;
         }
      }
      
      public function getSaveString() : String
      {
         var _loc1_:Array = new Array("m4",color.toString(16),this.blockBG.getSaveString(),this.bg1.getSaveString(),this.bg2.getSaveString(),this.bg3.getSaveString(),this.draw1.getSaveString(),this.draw2.getSaveString(),this.draw3.getSaveString(),this.bg.getSaveString(),this.bg4.getSaveString(),this.bg5.getSaveString(),this.draw4.getSaveString(),this.draw5.getSaveString());
         return _loc1_.join("`");
      }
      
      protected function setStartPos() : *
      {
         var _loc1_:Point = this.blockBG.getStartPos();
         posX = -_loc1_.x - 100;
         posY = -_loc1_.y - 50;
      }
      
      public function focusOn(param1:Background) : *
      {
         this.blockBG.method_22();
         this.bg1.method_22();
         this.bg2.method_22();
         this.bg3.method_22();
         this.bg4.method_22();
         this.bg5.method_22();
         this.draw1.method_22();
         this.draw2.method_22();
         this.draw3.method_22();
         this.draw4.method_22();
         this.draw5.method_22();
         param1.focusOn();
         this.var_225 = param1;
         this.menu.changeUndoRedoState();
         this.blockGrid.visible = param1 == this.blockBG;
         if(param1 == this.bg1 || param1 == this.draw1)
         {
            this.bg1.alpha = this.draw1.alpha = 1;
         }
         if(param1 == this.bg2 || param1 == this.draw2)
         {
            this.bg2.alpha = this.draw2.alpha = 1;
         }
         if(param1 == this.bg3 || param1 == this.draw3)
         {
            this.bg3.alpha = this.draw3.alpha = 1;
         }
         if(param1 == this.bg4 || param1 == this.draw4)
         {
            this.bg4.alpha = this.draw4.alpha = 1;
         }
         if(param1 == this.bg5 || param1 == this.draw5)
         {
            this.bg5.alpha = this.draw5.alpha = 1;
         }
      }
      
      public function focusNone() : *
      {
         this.blockGrid.visible = false;
         this.blockBG.focusNone();
         this.bg1.focusNone();
         this.bg2.focusNone();
         this.bg3.focusNone();
         this.bg4.focusNone();
         this.bg5.focusNone();
         this.draw1.focusNone();
         this.draw2.focusNone();
         this.draw3.focusNone();
         this.draw4.focusNone();
         this.draw5.focusNone();
      }
      
      override public function setSong(param1:String) : *
      {
         super.setSong(param1);
         this.menu.settings.musicButton.setSong(param1);
      }
      
      override public function setGravity(param1:String) : *
      {
         if(param1 == null || param1 == "")
         {
            param1 = "1";
         }
         super.setGravity(param1);
         this.menu.settings.gravityButton.setValue(this.gravity);
      }
      
      override public function setMaxTime(param1:String) : *
      {
         if(param1 == null || param1 == "")
         {
            param1 = "120";
         }
         super.setMaxTime(param1);
         this.menu.settings.timeButton.setValue(this.maxTime);
      }
      
      public function setMinRank(param1:String) : *
      {
         param1 = param1 == null || param1 == "" ? "0" : param1;
         this.minRank = param1;
         this.menu.settings.minRankButton.setValue(param1);
      }
      
      override public function setCowboyChance(param1:String) : *
      {
         param1 = param1 == null || param1 == "" ? "5" : param1;
         super.setCowboyChance(param1);
         this.menu.settings.sfcmButton.setValue(this.cowboyChance);
      }
      
      public function setPass(param1:String) : *
      {
         param1 = param1 == null ? "" : param1;
         this.hasPass = int(param1 != "");
         this.pass = param1;
         this.menu.settings.passButton.setValue(param1);
      }
      
      override public function setGameMode(param1:String) : *
      {
         param1 = param1 === "eggs" ? "egg" : param1;
         this.menu.settings.modeButton.setValue(param1);
         super.setGameMode(param1);
      }
      
      override public function setVariables(param1:URLVariables) : *
      {
         this.live = param1.live;
         this.setMinRank(param1.min_level);
         this.setPass(int(param1.has_pass) == 1 ? "******" : "");
         super.setVariables(param1);
         this.menu.reset();
      }
      
      public function method_344() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.title = title;
         _loc1_.note = note;
         _loc1_.data = this.getSaveString();
         _loc1_.credits = getCredits();
         _loc1_.live = this.live;
         _loc1_.min_level = this.minRank;
         _loc1_.song = song;
         _loc1_.gravity = gravity;
         _loc1_.max_time = maxTime;
         _loc1_.items = allowedItems.join("`");
         _loc1_.badHats = badHats.join(",");
         _loc1_.hasPass = this.hasPass;
         _loc1_.gameMode = gameMode === "eggs" ? "egg" : gameMode;
         _loc1_.cowboyChance = cowboyChance;
         _loc1_.passHash = this.pass != null && this.pass.replace(/\*/g,"").length > 0 ? Data.hash(this.pass + Env.LEVEL_PASS_SALT) : "";
         return _loc1_;
      }
      
      override public function setZoom(param1:Number) : *
      {
         super.setZoom(param1);
         this.blockGrid.setZoom(param1);
      }
      
      override protected function finishGlide() : *
      {
         Main.stage.quality = StageQuality.HIGH;
         super.finishGlide();
      }
      
      override protected function glideToScale(param1:Event) : *
      {
         super.glideToScale(param1);
         this.menu.scaleX = this.menu.scaleY = this.bg.scaleX = this.bg.scaleY = 1 / scale;
      }
      
      public function canViewLevelReports() : Boolean
      {
         return this.isMod;
      }
      
      public function inReportsMode() : Boolean
      {
         return this.reportsMode;
      }
      
      public function setReportsMode(param1:Boolean = false) : *
      {
         this.reportsMode = param1;
      }
      
      public function clear() : *
      {
         this.removeBackgrounds();
         this.attachBackgrounds();
         this.setMinRank("0");
         this.setPass("");
         this.setSong("");
         this.setGravity("1");
         this.setMaxTime("120");
         setItems("all");
         setBadHats("");
         this.setGameMode("race");
         this.setCowboyChance("5");
         title = "";
         note = "";
         this.live = 0;
         this.hasPass = 0;
         this.bg.scaleX = this.bg.scaleY = 1 / scale;
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.keyScroll);
         if(this.drawingPop != null)
         {
            this.drawingPop.remove();
         }
         this.menu.remove();
         super.remove();
         LevelEditor.editor = null;
      }
   }
}

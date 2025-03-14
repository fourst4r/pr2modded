package background
{
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.*;
   import levelEditor.*;
   import page.GamePage;
   
   public class DrawableBackground extends Background
   {
       
      
      public var var_210:Number = 200;
      
      public var var_541:int = 750;
      
      public var losslessQuality:Boolean = false;
      
      public var fromLE:Boolean;
      
      public var rasterCycles:Number = 1;
      
      public var bitmapArray:Array;
      
      public var brushCanvas:Sprite;
      
      public var var_122:Sprite;
      
      public var objCanvas:Sprite;
      
      public var brushSize:Number = 4;
      
      public var color:Number = 0;
      
      public var mode:String = "draw";
      
      public var brushX:Number;
      
      public var brushY:Number;
      
      public var drawing:Boolean = false;
      
      public var stoppedRasterizing:Boolean = false;
      
      public function DrawableBackground(param1:GamePage)
      {
         this.bitmapArray = new Array();
         this.brushCanvas = new Sprite();
         this.var_122 = new Sprite();
         this.objCanvas = new Sprite();
         super(param1);
         this.fromLE = LevelEditor.editor != null;
         this.losslessQuality = Settings.getValue(Settings.ART_LOSSLESS_QUALITY,false);
         this.var_122.cacheAsBitmap = true;
         addChild(this.var_122);
         addChild(this.brushCanvas);
         addChild(this.objCanvas);
         this.brushCanvas.graphics.lineStyle(this.brushSize,this.color);
      }
      
      public function method_86() : *
      {
         this.var_122.cacheAsBitmap = false;
         this.method_268(false);
      }
      
      public function method_74() : *
      {
         this.var_122.cacheAsBitmap = true;
         this.method_268(true);
      }
      
      public function method_268(param1:Boolean) : *
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.objCanvas.numChildren)
         {
            _loc3_ = this.objCanvas.getChildAt(_loc2_);
            _loc3_.cacheAsBitmap = param1;
            _loc2_++;
         }
      }
      
      override public function setSaveString(param1:String, param2:Boolean = true) : *
      {
         if(!Settings.getValue(Settings.DRAW_ART,true) && !param2)
         {
            param1 = "";
         }
         super.setSaveString(param1);
      }
      
      override public function setScale(param1:Number) : *
      {
         scale = param1;
         method_59();
      }
      
      public function rasterize() : *
      {
         this.method_446(this.var_122,this.bitmapArray);
      }
      
      public function method_446(param1:Sprite, param2:Array) : *
      {
         this.method_607(param1,param2,this.brushCanvas);
         this.brushCanvas.graphics.clear();
         this.brushCanvas.graphics.lineStyle(this.brushSize,this.color);
      }
      
      public function method_607(param1:Sprite, param2:Array, param3:Sprite) : *
      {
         var _loc4_:Rectangle = param3.getBounds(this);
         var _loc5_:int = this.var_210 * this.rasterCycles;
         var _loc6_:Number = Math.floor(_loc4_.x / _loc5_) * _loc5_;
         var _loc7_:Number = Math.floor(_loc4_.y / _loc5_) * _loc5_;
         var _loc8_:Number = _loc4_.x + _loc4_.width;
         var _loc9_:Number = _loc4_.y + _loc4_.height;
         var _loc10_:Number = _loc6_;
         var _loc11_:Number = _loc7_;
         while(_loc10_ < _loc8_)
         {
            _loc11_ = _loc7_;
            while(_loc11_ < _loc9_)
            {
               this.method_208(_loc10_,_loc11_,param1,param2,param3);
               _loc11_ += _loc5_;
            }
            _loc10_ += _loc5_;
         }
         if(!this.losslessQuality && !this.fromLE && this.rasterCycles < 5 && Main.var_184 >= this.var_541)
         {
            ++this.rasterCycles;
            this.clear();
            this.draw();
         }
         else if(this.rasterCycles >= 5)
         {
            this.stoppedRasterizing = true;
         }
      }
      
      public function method_208(param1:Number, param2:Number, param3:Sprite, param4:Array, param5:Sprite) : *
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc9_:DisplayObjectContainer = null;
         var _loc10_:Sprite = null;
         var _loc11_:BitmapData = null;
         var _loc12_:Bitmap = null;
         _loc6_ = Math.floor(param1 / (this.var_210 * this.rasterCycles));
         _loc7_ = Math.floor(param2 / (this.var_210 * this.rasterCycles));
         var _loc8_:Boolean = true;
         if(param4[_loc6_] == null)
         {
            param4[_loc6_] = new Array();
         }
         else if(param4[_loc6_][_loc7_] != null)
         {
            _loc8_ = false;
         }
         if(!_loc8_ || Main.var_184 <= this.var_541 || Boolean(this.losslessQuality) || Boolean(this.fromLE))
         {
            if(_loc8_)
            {
               ++Main.var_184;
               _loc11_ = new BitmapData(this.var_210 + 1,this.var_210 + 1,true,0);
               _loc12_ = new Bitmap(_loc11_);
               _loc12_.scaleX = _loc12_.scaleY = this.rasterCycles;
               param4[_loc6_][_loc7_] = _loc12_;
               if(param3 != this.var_122 || method_32(_loc6_,_loc7_))
               {
                  param3.addChild(_loc12_);
               }
               _loc12_.x = param1;
               _loc12_.y = param2;
            }
            _loc9_ = param5.parent;
            (_loc10_ = new Sprite()).addChild(param5);
            param5.scaleX = param5.scaleY = 1 / this.rasterCycles;
            param5.x = -(param1 * (1 / this.rasterCycles));
            param5.y = -(param2 * (1 / this.rasterCycles));
            Bitmap(param4[_loc6_][_loc7_]).bitmapData.draw(_loc10_);
            param5.x = param5.y = 0;
            param5.scaleX = param5.scaleY = 1;
            if(_loc9_ != null)
            {
               _loc9_.addChild(param5);
            }
         }
      }
      
      public function erase() : *
      {
         var _loc6_:Bitmap = null;
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Array = new Array();
         this.method_446(_loc1_,_loc2_);
         var _loc3_:Sprite = new Sprite();
         this.method_553(_loc3_,this.bitmapArray,_loc2_);
         var _loc4_:Sprite;
         (_loc4_ = new Sprite()).blendMode = BlendMode.LAYER;
         _loc1_.blendMode = BlendMode.ERASE;
         _loc4_.addChild(_loc3_);
         _loc4_.addChild(_loc1_);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.numChildren)
         {
            _loc6_ = Bitmap(_loc3_.getChildAt(_loc5_));
            this.method_208(_loc6_.x,_loc6_.y,this.var_122,this.bitmapArray,_loc4_);
            _loc5_++;
         }
         this.method_373(_loc1_);
         this.method_373(_loc3_);
         addChildAt(this.var_122,0);
         addChildAt(this.brushCanvas,1);
      }
      
      public function method_553(param1:Sprite, param2:Array, param3:Array) : *
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param3.length)
         {
            if(param3[_loc4_] != null)
            {
               _loc5_ = 0;
               while(_loc5_ < param3[_loc4_].length)
               {
                  if(param3[_loc4_][_loc5_] != null && param2[_loc4_] != null && param2[_loc4_][_loc5_] != null)
                  {
                     param1.addChild(param2[_loc4_][_loc5_]);
                     param2[_loc4_][_loc5_] = null;
                  }
                  _loc5_++;
               }
            }
            _loc4_++;
         }
      }
      
      override public function draw(param1:Number = 50) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         this.drawing = true;
         course.startDrawing(this);
         if(course.goodToDraw(this))
         {
            _loc2_ = new Date().time;
            this.brushCanvas.graphics.lineStyle(this.brushSize,this.color);
            _loc3_ = 0;
            while(var_39 < saveArray.length)
            {
               _loc5_ = (_loc4_ = String(saveArray[var_39])).substr(0,1);
               _loc6_ = _loc4_.substr(1);
               if(_loc5_ == "d")
               {
                  this.placeStroke(_loc6_);
               }
               else if(_loc5_ == "c")
               {
                  this.color = Number("0x" + _loc6_);
                  this.brushCanvas.graphics.lineStyle(this.brushSize,this.color);
               }
               else if(_loc5_ == "t")
               {
                  this.brushSize = Number(_loc6_);
                  this.brushCanvas.graphics.lineStyle(this.brushSize,this.color);
               }
               else if(_loc5_ == "m")
               {
                  this.mode = _loc6_;
               }
               else if(_loc5_ == "o")
               {
                  this.placeObject(_loc6_);
               }
               else if(_loc5_ == "u")
               {
                  this.drawText(_loc6_);
               }
               if(this.mode == "erase")
               {
                  this.erase();
               }
               if(this.mode == "draw")
               {
                  this.rasterize();
               }
               ++var_39;
               if((_loc7_ = new Date().time - _loc2_) > 50 && _loc3_ > 20 || _loc7_ > 250)
               {
                  break;
               }
               _loc3_++;
            }
         }
         if(var_39 >= saveArray.length)
         {
            this.drawing = false;
         }
         super.draw(param1);
      }
      
      override public function setPos(param1:Number, param2:Number) : *
      {
         super.setPos(param1,param2);
         var _loc3_:Point = Data.method_9(-course.posX,-course.posY,rotation);
         var _loc4_:int = Math.floor(_loc3_.x * scale / (this.var_210 * this.rasterCycles));
         var _loc5_:int = Math.floor(_loc3_.y * scale / (this.var_210 * this.rasterCycles));
         method_118(_loc4_,_loc5_,2,2,1,1,this.var_122,this.bitmapArray);
      }
      
      public function placeObject(param1:String) : *
      {
         var _loc4_:Number = NaN;
         var _loc2_:Array = param1.split(";");
         var _loc3_:Number = Number(_loc2_[3]);
         _loc4_ = Number(_loc2_[4]);
         var _loc5_:DisplayObject = Objects.getFromCode(Number(_loc2_[0]));
         _loc5_.scaleX = _loc5_.scaleY = scale;
         _loc5_.x = Number(_loc2_[1]) * scale;
         _loc5_.y = Number(_loc2_[2]) * scale;
         if(!isNaN(_loc3_) && !isNaN(_loc4_))
         {
            _loc5_.scaleX *= _loc3_;
            _loc5_.scaleY *= _loc4_;
         }
         _loc5_.cacheAsBitmap = true;
         this.objCanvas.addChild(_loc5_);
      }
      
      public function drawText(param1:String) : *
      {
         var _loc2_:Array = param1.split(";");
         var _loc3_:String = String(_loc2_[0]);
         var _loc4_:int = int(_loc2_[1]);
         var _loc5_:int = int(_loc2_[2]);
         var _loc6_:int = int(_loc2_[3]);
         var _loc7_:Number = Number(_loc2_[4]) / 100;
         var _loc8_:Number = Number(_loc2_[5]) / 100;
         var _loc9_:TextField;
         (_loc9_ = new TextObjectGraphic().textBox).selectable = false;
         _loc9_.wordWrap = false;
         _loc9_.autoSize = TextFieldAutoSize.LEFT;
         _loc9_.multiline = true;
         _loc9_.textColor = _loc6_;
         _loc9_.text = TextObject.parseText(_loc3_);
         _loc9_.scaleX = _loc7_ * scale;
         _loc9_.scaleY = _loc8_ * scale;
         _loc9_.height = 24;
         _loc9_.x = _loc4_ * scale;
         _loc9_.y = _loc5_ * scale;
         _loc9_.cacheAsBitmap = true;
         this.objCanvas.addChild(_loc9_);
      }
      
      public function placeStroke(param1:String) : *
      {
         var _loc2_:Array = param1.split(";");
         this.initBrushMove(_loc2_[0],_loc2_[1]);
         var _loc3_:int = 2;
         while(_loc3_ < _loc2_.length)
         {
            this.drawLine(_loc2_[_loc3_],_loc2_[_loc3_ + 1]);
            _loc3_ += 2;
         }
      }
      
      public function recordColor(param1:Number) : *
      {
         if(this.color != param1)
         {
            this.color = param1;
            this.brushCanvas.graphics.lineStyle(this.brushSize,this.color);
            recordAction("c" + this.color.toString(16));
         }
      }
      
      public function setBrushSize(param1:Number) : *
      {
         if(this.brushSize != param1)
         {
            this.brushSize = param1;
            this.brushCanvas.graphics.lineStyle(param1,this.color);
            recordAction("t" + param1);
         }
      }
      
      public function setMode(param1:String) : *
      {
         if(this.mode != param1)
         {
            this.mode = param1;
            recordAction("m" + param1);
         }
      }
      
      public function moveTo(param1:Number, param2:Number) : *
      {
         recordAction("d" + param1 + ";" + param2);
         if(!this.drawing)
         {
            this.initBrushMove(param1,param2);
         }
      }
      
      public function lineTo(param1:Number, param2:Number) : *
      {
         var _loc3_:Number = param1 - this.brushX;
         var _loc4_:Number = param2 - this.brushY;
         saveArray[saveArray.length - 1] = saveArray[saveArray.length - 1] + ";" + _loc3_ + ";" + _loc4_;
         if(!this.drawing)
         {
            this.drawLine(_loc3_,_loc4_);
         }
      }
      
      public function initBrushMove(param1:Number, param2:Number) : *
      {
         this.brushCanvas.graphics.moveTo(param1,param2);
         this.brushCanvas.graphics.lineTo(param1 - 0.15,param2);
         this.brushCanvas.graphics.moveTo(param1,param2);
         this.brushX = param1;
         this.brushY = param2;
      }
      
      public function drawLine(param1:Number, param2:Number) : *
      {
         this.brushX += param1;
         this.brushY += param2;
         this.brushCanvas.graphics.lineTo(this.brushX,this.brushY);
      }
      
      override public function undo() : *
      {
         var _loc2_:String = null;
         var _loc1_:int = saveArray.length - 2;
         while(_loc1_ >= 0)
         {
            _loc2_ = String(saveArray[_loc1_]);
            if(_loc2_.charAt(0) == "d")
            {
               break;
            }
            redoArray.push(saveArray.pop());
            _loc1_--;
         }
         super.undo();
      }
      
      override public function redo() : *
      {
         var _loc2_:String = null;
         var _loc1_:Number = redoArray.length - 2;
         while(_loc1_ >= 0)
         {
            _loc2_ = String(redoArray[_loc1_]);
            if(_loc2_.charAt(0) == "d")
            {
               break;
            }
            saveArray.push(redoArray.pop());
            _loc1_--;
         }
         super.redo();
      }
      
      override public function clear() : *
      {
         this.method_812(this.bitmapArray);
         this.bitmapArray = new Array();
         this.brushCanvas.graphics.clear();
         this.color = 0;
         this.brushSize = 4;
         this.mode = "draw";
         super.clear();
      }
      
      public function method_373(param1:Sprite) : *
      {
         var _loc2_:Bitmap = null;
         while(param1.numChildren != 0)
         {
            _loc2_ = Bitmap(param1.getChildAt(0));
            this.method_248(_loc2_);
         }
      }
      
      public function method_812(param1:Array) : *
      {
         var _loc2_:Array = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:Bitmap = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_ != null)
            {
               for each(_loc3_ in _loc2_)
               {
                  _loc4_ = Bitmap(_loc3_);
                  this.method_248(_loc4_);
               }
            }
         }
      }
      
      public function method_248(param1:Bitmap) : *
      {
         if(param1 != null)
         {
            --Main.var_184;
            param1.bitmapData.dispose();
            param1.bitmapData = null;
            if(param1.parent != null)
            {
               param1.parent.removeChild(param1);
            }
            param1 = null;
         }
      }
      
      override public function remove() : *
      {
         this.clear();
         super.remove();
      }
   }
}

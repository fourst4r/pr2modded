package levelEditor
{
   import blocks.*;
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class DrawObject extends Removable
   {
       
      
      public var var_621:Number;
      
      public var var_603:Number;
      
      public var var_625:Number;
      
      public var var_582:Number;
      
      public var startWidth:Number;
      
      public var startHeight:Number;
      
      public var textObj:Boolean = false;
      
      public var deleteable:Boolean = true;
      
      public var resizable:Boolean = true;
      
      public var deleteButton:DeleteButton;
      
      public var resizeButton:ResizeButton;
      
      public var m:DisplayObject;
      
      public var highlightOutline:Sprite;
      
      public var editor:LevelEditor;
      
      public var stageRef:Stage;
      
      public var holder:Sprite;
      
      public var displayCode:int;
      
      public var buttonScaleX:Number = 1;
      
      public var buttonScaleY:Number = 1;
      
      public function DrawObject(param1:int, param2:Number, param3:Number)
      {
         this.highlightOutline = new Sprite();
         this.editor = LevelEditor.editor;
         this.stageRef = Main.stage;
         super();
         this.displayCode = param1;
         x = param2;
         y = param3;
         this.m = Objects.getFromCode(this.displayCode);
         this.deleteable = !(this.m is StartBlock);
         this.textObj = this is TextObject;
         this.recordRealDimensions();
         addChild(this.m);
         this.m.addEventListener(MouseEvent.MOUSE_DOWN,this.beginDrag);
         addEventListener(Event.ADDED,this.addedHandler,false,0,true);
      }
      
      public function addedHandler(param1:Event) : *
      {
         this.holder = Sprite(parent);
      }
      
      public function beginDrag(param1:MouseEvent) : *
      {
         this.stageRef.addEventListener(MouseEvent.MOUSE_MOVE,this.onDrag);
         this.stageRef.addEventListener(MouseEvent.MOUSE_UP,this.endDrag);
         this.stageRef.focus = this.stageRef;
         var _loc2_:Point = this.holder.globalToLocal(new Point(param1.stageX,param1.stageY));
         this.var_621 = x - _loc2_.x;
         this.var_603 = y - _loc2_.y;
         this.var_625 = x;
         this.var_582 = y;
         parent.swapChildren(this,parent.getChildAt(this.holder.numChildren - 1));
         alpha = 0.75;
      }
      
      public function recordRealDimensions() : *
      {
         var _loc1_:Number = scaleX;
         var _loc2_:Number = scaleY;
         scaleX = 1;
         scaleY = 1;
         this.startWidth = this.m.width;
         this.startHeight = this.m.height;
         scaleX = _loc1_;
         scaleY = _loc2_;
      }
      
      public function onDrag(param1:MouseEvent) : *
      {
         var _loc2_:Point = this.holder.globalToLocal(new Point(param1.stageX,param1.stageY));
         _loc2_.x += this.var_621;
         _loc2_.y += this.var_603;
         x = _loc2_.x;
         y = _loc2_.y;
      }
      
      public function endDrag(param1:MouseEvent) : *
      {
         this.stageRef.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDrag);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_UP,this.endDrag);
         alpha = 1;
         x = Math.round(x);
         y = Math.round(y);
         if(x != this.var_625 || y == this.var_582)
         {
            this.editor.cur.recordMove(this);
         }
         this.holder.addChild(this);
         this.select();
      }
      
      public function select() : *
      {
         this.makeHighlightOutline();
         addChild(this.highlightOutline);
         this.stageRef.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         if(this.deleteable)
         {
            if(!this.textObj)
            {
               this.stageRef.addEventListener(KeyboardEvent.KEY_DOWN,this.onDelPress);
            }
            this.showDeleteButton();
         }
         if(this.resizable)
         {
            this.showResizeButton();
         }
         this.positionInternals();
      }
      
      public function deselect() : *
      {
         this.stageRef.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this.stageRef.removeEventListener(KeyboardEvent.KEY_DOWN,this.onDelPress);
         removeChild(this.highlightOutline);
         this.hideDeleteButton();
         this.hideResizeButton();
      }
      
      public function mouseDownHandler(param1:MouseEvent) : *
      {
         this.deselect();
      }
      
      public function onDelPress(param1:KeyboardEvent) : *
      {
         if(this.deleteable === true && (param1.keyCode === 46 || param1.keyCode === 8))
         {
            this.deleteObject();
         }
      }
      
      public function deleteObject(param1:MouseEvent = null) : *
      {
         this.editor.cur.recordDelete(this);
         this.remove();
      }
      
      public function onResizePress(param1:MouseEvent) : *
      {
         this.stageRef.addEventListener(MouseEvent.MOUSE_MOVE,this.resize);
         this.stageRef.addEventListener(MouseEvent.MOUSE_UP,this.onResizeUp);
      }
      
      public function resize(param1:MouseEvent) : *
      {
         var _loc2_:Point = this.holder.globalToLocal(new Point(param1.stageX,param1.stageY));
         var _loc3_:Number = _loc2_.x - x;
         var _loc4_:Number = _loc2_.y - y;
         scaleX = _loc3_ * (100 / this.startWidth) / 100;
         scaleY = _loc4_ * (100 / this.startHeight) / 100;
      }
      
      public function onResizeUp(param1:MouseEvent) : *
      {
         this.stageRef.removeEventListener(MouseEvent.MOUSE_MOVE,this.resize);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_UP,this.onResizeUp);
         this.select();
         scaleX = Math.round(scaleX * 100) / 100;
         scaleY = Math.round(scaleY * 100) / 100;
         this.editor.cur.recordResize(this);
      }
      
      public function showDeleteButton() : *
      {
         this.deleteButton = new DeleteButton();
         this.deleteButton.addEventListener(MouseEvent.MOUSE_DOWN,this.deleteObject,false,0,true);
         addChild(this.deleteButton);
      }
      
      public function hideDeleteButton() : *
      {
         if(this.deleteButton != null)
         {
            this.deleteButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.deleteObject);
            removeChild(this.deleteButton);
            this.deleteButton = null;
         }
      }
      
      public function showResizeButton() : *
      {
         this.resizeButton = new ResizeButton();
         addChild(this.resizeButton);
         this.resizeButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onResizePress,false,0,true);
      }
      
      public function hideResizeButton() : *
      {
         if(this.resizeButton != null)
         {
            this.resizeButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.onResizePress);
            removeChild(this.resizeButton);
            this.resizeButton = null;
         }
      }
      
      public function setButtonScale() : *
      {
         this.buttonScaleX = 1 / scaleX * (1 / parent.scaleX) * (1 / parent.parent.scaleX) * (1 / parent.parent.parent.scaleX);
         this.buttonScaleY = 1 / scaleY * (1 / parent.scaleY) * (1 / parent.parent.scaleY) * (1 / parent.parent.parent.scaleY);
      }
      
      public function positionInternals() : *
      {
         this.setButtonScale();
         if(this.deleteButton != null)
         {
            this.deleteButton.x = 0;
            this.deleteButton.y = this.m.height;
            this.deleteButton.scaleX = this.buttonScaleX;
            this.deleteButton.scaleY = this.buttonScaleY;
         }
         if(this.resizeButton != null)
         {
            this.resizeButton.x = this.m.width;
            this.resizeButton.y = this.m.height;
            this.resizeButton.scaleX = this.buttonScaleX;
            this.resizeButton.scaleY = this.buttonScaleY;
         }
      }
      
      public function makeHighlightOutline() : *
      {
         this.highlightOutline.graphics.clear();
         this.highlightOutline.graphics.lineStyle(3,16777215,1,false,"none");
         this.highlightOutline.graphics.moveTo(0,0);
         this.highlightOutline.graphics.lineTo(0,this.m.height);
         this.highlightOutline.graphics.lineTo(this.m.width,this.m.height);
         this.highlightOutline.graphics.lineTo(this.m.width,0);
         this.highlightOutline.graphics.lineTo(0,0);
      }
      
      public function hideHighlight() : *
      {
         this.highlightOutline.graphics.clear();
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ADDED,this.addedHandler);
         this.m.removeEventListener(MouseEvent.MOUSE_DOWN,this.beginDrag);
         this.stageRef.removeEventListener(KeyboardEvent.KEY_DOWN,this.onDelPress);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_UP,this.endDrag);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDrag);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_MOVE,this.resize);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_UP,this.onResizeUp);
         this.hideResizeButton();
         this.hideDeleteButton();
         LevelEditor.editor.cur.method_771(this);
         super.remove();
      }
   }
}

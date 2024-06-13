package blocks.options
{
   import blocks.Block;
   import fl.controls.CheckBox;
   import items.*;
   import page.*;
   
   public class ItemBlockOptions extends BlockOptions
   {
       
      
      private const NUM_ITEMS:int = Items.getAllCodes().length;
      
      public function ItemBlockOptions(param1:Block)
      {
         var _loc4_:CheckBox = null;
         m = new ItemBlockOptionsGraphic();
         super(param1);
         var _loc2_:Vector.<int> = new Vector.<int>();
         if(param1.options == "")
         {
            _loc2_ = GamePage.course.allowedItems;
         }
         else if(param1.options != "none")
         {
            _loc2_ = Vector.<int>(param1.options.split("-"));
         }
         var _loc3_:int = 1;
         while(_loc3_ <= this.NUM_ITEMS)
         {
            (_loc4_ = this.m["check" + _loc3_]).selected = _loc2_.indexOf(_loc3_) != -1;
            _loc3_++;
         }
      }
      
      override public function remove() : *
      {
         var _loc3_:CheckBox = null;
         var _loc1_:Vector.<int> = new Vector.<int>();
         var _loc2_:int = 1;
         while(_loc2_ <= this.NUM_ITEMS)
         {
            _loc3_ = this.m["check" + _loc2_];
            if(_loc3_.selected)
            {
               _loc1_.push(_loc2_);
            }
            _loc2_++;
         }
         block.applyOptions(_loc1_.length > 0 ? _loc1_.join("-") : "none");
         super.remove();
      }
   }
}

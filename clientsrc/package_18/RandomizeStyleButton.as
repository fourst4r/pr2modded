package package_18
{
   public class RandomizeStyleButton extends HoverDelayPopup
   {
       
      
      public var m:RandomizeStyleButtonGraphic;
      
      public function RandomizeStyleButton()
      {
         this.m = new RandomizeStyleButtonGraphic();
         addChild(this.m);
         super("Randomize Style","Create a random style for your character. Remember to save your current style if you like it first!");
      }
   }
}

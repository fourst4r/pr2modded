package package_14
{
   import levelEditor.*;
   import package_19.*;
   
   public class Settings extends SideBar
   {
       
      
      public var editor:LevelEditor;
      
      public var musicTitle:String = "Music";
      
      public var musicDesc:String = "This song will play by default for users playing your course.";
      
      public var musicButton:MusicMenuButton;
      
      public var itemsTitle:String = "Items";
      
      public var itemsDesc:String = "These items will be available to players in your course\'s item boxes.";
      
      public var itemsButton:ItemMenuButton;
      
      public var hatsTitle:String = "Hats Allowed";
      
      public var hatsDesc:String = "Players may use these hats in your level.";
      
      public var hatsButton:HatsMenuButton;
      
      public var rankTitle:String = "Minimum Rank";
      
      public var rankDesc:String = "Players below this rank will not be able to race on this course.";
      
      public var minRankButton:ValueButton;
      
      public var gravityTitle:String = "Gravity Multiplier";
      
      public var gravityDesc:String = "Normal gravity will be multiplied by the number you provide.";
      
      public var gravityButton:ValueButton;
      
      public var timeTitle:String = "Time Limit";
      
      public var timeDesc:String = "Racers will have this amount of seconds to complete this course. Enter 0 for infinite time.";
      
      public var timeButton:ValueButton;
      
      public var passTitle:String = "Secret Password";
      
      public var passDesc:String = "This password lets players play your course while unpublished.";
      
      public var passButton:ValueButton;
      
      public var modeTitle:String = "Game Mode";
      
      public var modeDesc:String = "Each game mode has a different goal and method of winning.";
      
      public var modeButton:ModeMenuButton;
      
      public var sfcmTitle:String = "Chance of Cowboy Mode";
      
      public var sfcmDesc:String = "Super Flying Cowboy Mode will appear this often out of 100.";
      
      public var sfcmButton:ValueButton;
      
      public function Settings()
      {
         this.editor = LevelEditor.editor;
         this.musicButton = new MusicMenuButton();
         this.itemsButton = new ItemMenuButton();
         this.hatsButton = new HatsMenuButton();
         this.minRankButton = new ValueButton("rank",this.rankTitle,this.rankDesc,"0",this.editor.setMinRank,2);
         this.gravityButton = new ValueButton("grav",this.gravityTitle,this.gravityDesc,"1.0",this.editor.setGravity,4,"-.0123456789");
         this.timeButton = new ValueButton("time",this.timeTitle,this.timeDesc,"120",this.editor.setMaxTime,4);
         this.passButton = new ValueButton("pass",this.passTitle,this.passDesc,"",this.editor.setPass,32,null,"",false);
         this.modeButton = new ModeMenuButton();
         this.sfcmButton = new ValueButton("sfcm",this.sfcmTitle,this.sfcmDesc,"5",this.editor.setCowboyChance,3);
         super();
         addItem(this.musicButton,this.musicTitle,this.musicDesc);
         addItem(this.itemsButton,this.itemsTitle,this.itemsDesc);
         addItem(this.hatsButton,this.hatsTitle,this.hatsDesc);
         addItem(this.minRankButton,this.rankTitle,this.rankDesc);
         addItem(this.gravityButton,this.gravityTitle,this.gravityDesc);
         addItem(this.timeButton,this.timeTitle,this.timeDesc);
         addItem(this.modeButton,this.modeTitle,this.modeDesc);
         addItem(this.sfcmButton,this.sfcmTitle,this.sfcmDesc);
         addItem(this.passButton,this.passTitle,this.passDesc);
      }
   }
}

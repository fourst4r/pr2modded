package lobby
{
   import package_22.*;
   import ui.*;
   
   public class LobbyRight extends LobbySide
   {
      
      public static var lobbyRight:LobbyRight;
       
      
      public var campaignTab:LobbyTab;
      
      public var atbTab:LobbyTab;
      
      public var wbTab:LobbyTab;
      
      public var newTab:LobbyTab;
      
      public var searchTab:LobbyTab;
      
      public var favsTab:LobbyTab;
      
      public function LobbyRight()
      {
         this.campaignTab = new LobbyTab(this.clickCampaign,"Campaign");
         this.atbTab = new LobbyTab(this.clickBest,"All Time Best");
         this.wbTab = new LobbyTab(this.clickBestWeek,"Week\'s Best");
         this.newTab = new LobbyTab(this.clickNew,"Newest");
         this.searchTab = new LobbyTab(this.clickSearch,"Search");
         this.favsTab = new LobbyTab(this.clickFavs,"♥");
         LobbyRight.lobbyRight = this;
         x = 200;
         y = 3;
         var _loc1_:Array = [this.campaignTab,this.atbTab,this.wbTab,this.newTab,this.searchTab];
         if(Main.group >= 1)
         {
            _loc1_.push(this.favsTab);
         }
         super(_loc1_,"lobbyRight",0,347,356);
         if(Main.testing)
         {
            this.lookupUser("bIs1999");
         }
      }
      
      public function clickCampaign() : *
      {
         changePage(new Campaign());
      }
      
      public function clickBest() : *
      {
         changePage(new Best());
      }
      
      public function clickBestWeek() : *
      {
         changePage(new BestWeek());
      }
      
      public function clickNew() : *
      {
         changePage(new Newest());
      }
      
      public function clickSearch() : *
      {
         changePage(new Search());
      }
      
      public function clickFavs() : *
      {
         changePage(new Favorites());
      }
      
      public function lookupUser(param1:String = "") : *
      {
         this.searchTab.select();
         changePage(new Search(param1));
      }
      
      public function lookupLevel(param1:String = "") : *
      {
         this.searchTab.select();
         changePage(new Search(param1,"id"));
      }
      
      override public function remove() : *
      {
         LobbyRight.lobbyRight = null;
         this.campaignTab = this.atbTab = this.wbTab = this.newTab = this.searchTab = this.favsTab = null;
         super.remove();
      }
   }
}

package package_23
{
   import page.*;
   import ui.*;
   
   public class PlayersTab extends Page
   {
       
      
      public var tabsHolder:TabsHolder;
      
      public var pageHolder:PageHolder;
      
      public function PlayersTab()
      {
         this.pageHolder = new PageHolder();
         super();
         var _loc1_:LobbyTab = new LobbyTab(this.clickOnline,"Online");
         var _loc2_:LobbyTab = new LobbyTab(this.clickFriends,"Friends");
         var _loc3_:LobbyTab = new LobbyTab(this.clickFollowing,"Following");
         var _loc4_:LobbyTab = new LobbyTab(this.clickIgnored,"Ignored");
         var _loc5_:LobbyTab = new LobbyTab(this.clickGuilds,"Guilds");
         var _loc6_:Array = Main.group > 0 ? [_loc1_,_loc2_,_loc3_,_loc4_] : [_loc1_,_loc5_];
         this.tabsHolder = new TabsHolder(_loc6_,"playerLists",0,186);
         addChild(this.tabsHolder);
         this.pageHolder.y = 20;
         addChild(this.pageHolder);
      }
      
      public function clickOnline() : *
      {
         this.pageHolder.changePage(new Online());
      }
      
      public function clickFriends() : *
      {
         this.pageHolder.changePage(new Friends());
      }
      
      public function clickFollowing() : *
      {
         this.pageHolder.changePage(new Following());
      }
      
      public function clickIgnored() : *
      {
         this.pageHolder.changePage(new Ignored());
      }
      
      public function clickGuilds() : *
      {
         this.pageHolder.changePage(new Guilds());
      }
      
      override public function remove() : *
      {
         this.tabsHolder.remove();
         this.pageHolder.remove();
         super.remove();
      }
   }
}

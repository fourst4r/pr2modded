package package_4
{
   import flash.events.*;
   
   public class AdminMenu extends Removable
   {
       
      
      private var m:AdminMenuGraphic;
      
      private var target:Popup;
      
      private var userName:String;
      
      private var mode:String;
      
      public function AdminMenu(param1:String, param2:Popup)
      {
         this.m = new AdminMenuGraphic();
         super();
         this.userName = param1;
         this.target = param2;
         this.m.tempMod_bt.addEventListener(MouseEvent.CLICK,this.clickTemp,false,0,true);
         this.m.trialMod_bt.addEventListener(MouseEvent.CLICK,this.clickTrial,false,0,true);
         this.m.permaMod_bt.addEventListener(MouseEvent.CLICK,this.clickPerma,false,0,true);
         this.m.demote_bt.addEventListener(MouseEvent.CLICK,this.clickDemote,false,0,true);
         addChild(this.m);
      }
      
      private function clickTemp(param1:MouseEvent) : *
      {
         this.mode = "temporary";
         new ConfirmPopup(this.promoteModerator,"Are you sure you want to promote " + this.userName + " to a temporary moderator? They will be a moderator on this server until they log off. They will be able to administer 30 minute server kicks.");
      }
      
      private function clickTrial(param1:MouseEvent) : *
      {
         this.mode = "trial";
         new ConfirmPopup(this.promoteModerator,"Are you sure you want to promote " + this.userName + " to a trial moderator? They will only be able to ban for up to a day.");
      }
      
      private function clickPerma(param1:MouseEvent) : *
      {
         this.mode = "permanent";
         new ConfirmPopup(this.promoteModerator,"Are you sure you want to promote " + this.userName + " to a permanent moderator? They will be able to ban for up to a year, see IP addresses, unpublish levels, edit guilds, and use the PR2 Hub moderation tools.");
      }
      
      private function clickDemote(param1:MouseEvent) : *
      {
         this.mode = null;
         new ConfirmPopup(this.demoteModerator,"Are you sure you want to demote " + this.userName + "?");
      }
      
      private function promoteModerator() : *
      {
         Main.socket.write("promote_to_moderator`" + this.userName + "`" + this.mode);
         this.target.startFadeOut();
      }
      
      private function demoteModerator() : *
      {
         Main.socket.write("demote_moderator`" + this.userName);
         this.target.startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.tempMod_bt.removeEventListener(MouseEvent.CLICK,this.clickTemp);
         this.m.trialMod_bt.removeEventListener(MouseEvent.CLICK,this.clickTrial);
         this.m.permaMod_bt.removeEventListener(MouseEvent.CLICK,this.clickPerma);
         this.m.demote_bt.removeEventListener(MouseEvent.CLICK,this.clickDemote);
         this.target = null;
         super.remove();
      }
   }
}

package com.jiggmin.data
{
   import flash.events.*;
   import package_4.*;
   
   public class HTMLNameMaker
   {
       
      
      private var array:Array;
      
      public function HTMLNameMaker()
      {
         this.array = new Array();
         super();
      }
      
      public function makeName(param1:String, param2:String, param3:String = "") : String
      {
         var _loc7_:String = null;
         var _loc4_:Array = param2.split(",");
         var _loc5_:int = int(_loc4_[0]);
         var _loc6_:String = !_loc4_[1] ? null : String(_loc4_[1]);
         if(_loc5_ === 1)
         {
            if(_loc6_ == 1)
            {
               _loc7_ = "BC9055";
            }
            else
            {
               _loc7_ = "047B7B";
            }
         }
         else if(_loc5_ === 2)
         {
            if(_loc6_ == 0)
            {
               _loc7_ = "006400";
            }
            else if(_loc6_ == 1)
            {
               _loc7_ = "0092FF";
            }
            else
            {
               _loc7_ = "1C369F";
            }
         }
         else if(_loc5_ === 3)
         {
            _loc7_ = "870A6F";
         }
         else
         {
            _loc7_ = "676666";
         }
         if(_loc6_ === "*")
         {
            _loc7_ = "83C141";
         }
         if(param3 == "")
         {
            param3 = param1;
         }
         param1 = String(Data.cleanHTML(param1));
         param3 = String(Data.cleanHTML(param3));
         return "<u><font color=\"#" + _loc7_ + "\"><a href=\"event:user`" + _loc5_ + "`" + param1 + "\">" + param3 + "</a></font></u>";
      }
      
      public function makeGuild(param1:String, param2:int) : String
      {
         param1 = String(Data.escapeString(param1));
         return "<u><font color=\"#0000FF\"><a href=\"event:guild`" + param2 + "\">" + param1 + "</a></font></u>";
      }
      
      public function makeLevel(param1:String, param2:int) : String
      {
         param1 = String(Data.escapeString(param1));
         return "<u><font color=\"#0000FF\"><a href=\"event:level`" + param2 + "\">" + param1 + "</a></font></u>";
      }
      
      public function makeLink(param1:String, param2:String) : String
      {
         param1 = String(Data.escapeString(param1));
         param2 = String(encodeURI(Data.escapeString(param2)));
         return "<u><font color=\"#0000FF\"><a href=\"event:url`" + param2 + "\">" + param1 + "</a></font></u>";
      }
      
      public function listenForLink(param1:*) : *
      {
         this.array.push(param1);
         param1.addEventListener(TextEvent.LINK,this.clickLink,false,0,true);
      }
      
      private function clickLink(param1:TextEvent) : *
      {
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc3_:Array = param1.text.split("`");
         var _loc4_:String;
         if((_loc4_ = String(_loc3_[0])) == "user")
         {
            _loc5_ = String(_loc3_[1]);
            _loc6_ = String(_loc3_[2]);
            _loc7_ = Boolean(int(_loc3_[3]));
            if(_loc5_.indexOf(",") != -1)
            {
               _loc8_ = _loc5_.split(",");
               _loc5_ = String(int(_loc8_[0]));
            }
            if(_loc5_ > 0 || _loc7_)
            {
               new PlayerPopup(_loc6_);
            }
            else
            {
               new PlayerGuestPopup(_loc6_);
            }
         }
         else if(_loc4_ == "guild")
         {
            _loc2_ = int(_loc3_[1]);
            new GuildPopup(_loc2_);
         }
         else if(_loc4_ == "invite")
         {
            _loc2_ = int(_loc3_[1]);
            new GuildJoinPopup(_loc2_);
         }
         else if(_loc4_ == "level")
         {
            _loc9_ = int(_loc3_[1]);
            new LevelInfoPopup(_loc9_);
         }
         else if(_loc4_ == "url")
         {
            _loc10_ = String(_loc3_[1]);
            new ExternalLinkPopup(_loc10_);
         }
         else if(_loc4_ == "discordverify")
         {
            _loc11_ = String(_loc3_[1]);
            new DiscordVerificationPopup(_loc11_);
         }
      }
      
      public function remove() : *
      {
         var _loc3_:* = undefined;
         var _loc1_:int = int(this.array.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.array[_loc2_];
            if(_loc3_ != null)
            {
               _loc3_.removeEventListener(TextEvent.LINK,this.clickLink);
               _loc3_ = null;
            }
            _loc2_++;
         }
         this.array = null;
      }
   }
}

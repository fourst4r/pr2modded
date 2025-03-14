package menu
{
   import com.jiggmin.pixelEffects.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.media.*;
   import page.Page;
   
   public class IntroPage extends Page
   {
      
      public static const JIGG_INTRO:int = 1;
      
      public static const ARMOR_INTRO:int = 2;
      
      public static const BUBBOX_INTRO:int = 3;
      
      public static const KONG_INTRO:int = 4;
       
      
      public var toPlay:Array;
      
      public var m:IntroPageGraphic;
      
      public var currentIntro:MovieClip;
      
      public var mute:SoundTransform;
      
      public function IntroPage()
      {
         this.toPlay = new Array();
         this.mute = new SoundTransform();
         super();
         this.m = new IntroPageGraphic();
         addChild(this.m);
         this.mute.volume = 0;
         if(Main.siteMode == "inXile")
         {
            this.toPlay = [JIGG_INTRO];
         }
         else if(Main.siteMode == "bubbleBox")
         {
            this.toPlay = [JIGG_INTRO,BUBBOX_INTRO];
         }
         else if(Main.siteMode == "kongregate")
         {
            this.toPlay = [JIGG_INTRO,KONG_INTRO];
         }
         else if(Main.siteMode == "armorGames")
         {
            this.toPlay = [JIGG_INTRO,ARMOR_INTRO];
         }
         Main.stage.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         this.method_302();
      }
      
      public function onClick(param1:MouseEvent) : *
      {
         this.endIntro();
      }
      
      public function method_302() : *
      {
         var _loc1_:int = 0;
         var _loc2_:PixelEffect1 = null;
         this.method_322();
         if(this.toPlay.length <= 0)
         {
            this.endIntro();
         }
         else
         {
            _loc1_ = int(this.toPlay.shift());
            if(_loc1_ == JIGG_INTRO)
            {
               this.currentIntro = new JiggminIntroGraphic();
               _loc2_ = new PixelEffect1(new JiggminLogo(300,87));
               this.currentIntro.logo.logo_mc.addChild(_loc2_);
            }
            else if(_loc1_ == ARMOR_INTRO)
            {
               this.currentIntro = new ArmorIntroGraphic();
            }
            else if(_loc1_ == BUBBOX_INTRO)
            {
               this.currentIntro = new BubbleBoxIntroGraphic();
            }
            else if(_loc1_ == KONG_INTRO)
            {
               this.currentIntro = new KongregateIntroGraphic();
            }
            this.currentIntro.addEventListener(Event.COMPLETE,this.onComplete,false,0,true);
            this.m.introHolder.addChild(this.currentIntro);
         }
      }
      
      public function method_322() : *
      {
         if(this.currentIntro != null)
         {
            this.currentIntro.stop();
            this.currentIntro.soundTransform = this.mute;
            this.currentIntro.removeEventListener(Event.COMPLETE,this.onComplete);
            this.m.introHolder.removeChild(this.currentIntro);
            this.currentIntro = null;
         }
      }
      
      public function onComplete(param1:Event) : *
      {
         this.method_302();
      }
      
      public function endIntro() : *
      {
         this.method_322();
         Main.pageHolder.changePage(new LoginPage());
      }
      
      override public function remove() : *
      {
         Main.stage.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.method_322();
         this.m = null;
         this.currentIntro = null;
         super.remove();
      }
   }
}

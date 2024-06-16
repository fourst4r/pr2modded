package modhub.ui;

import api.Game;
import modding.ModContext;
import haxe.io.Path;
import modding.ModLoader;
import flash.system.SecurityDomain;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.Security;
import flash.utils.ByteArray;
import haxe.crypto.Base64;
import package_4.MessagePopup;
import package_4.Popup;
import ui.ProgressBar;
import flash.net.*;
import flash.events.*;
import flash.display.*;

class InstallingModsPopup extends Popup {
    
    var progressBar:ProgressBar;
    
    var m:UploadingPopupGraphic;
    
    public function new(mods:Array<ModInfo>) {
        this.progressBar = new ProgressBar();
        this.m = new UploadingPopupGraphic();
        super();
        this.m.textBox.text = "sometext";
        addChild(this.m);
        addChild(this.progressBar);
        this.progressBar.x = -100;
        this.progressBar.y = -5;

        m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);

        for (mod in mods) {
            // loadMod(mod);
        }   
    }

    function onSelect(event) {
        _file.load();

        trace("onSelect");

    }

    function onComplete(e) {
        trace("onComplete");
        final ctx = new LoaderContext();
        // ctx.securityDomain = SecurityDomain.currentDomain;
        ctx.applicationDomain = ApplicationDomain.currentDomain;
        ctx.allowCodeImport = true;
        addChild(_loader);
        _loader.loadBytes(_file.data, ctx);
    }

    // function onDownloadComplete(e:Event) {
    //     final urlLoader:URLLoader = e.target;
    //     final data:ByteArray = urlLoader.data;
    //     // final file = new FileReference();
    //     // file.save(data, "data.swf");
    //     // file.save(swf, "REDEARTH.swf");
        
    //     final ctx = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
    //     ctx.allowCodeImport = true;
    //     addChild(_loader);
    //     _loader.loadBytes(data, ctx);
    // }
    
    function onLoaderComplete(param1:Event)  {
trace("onComplete");
        this.progressBar.incProgress(1);
        final loaderInfo:LoaderInfo = param1.target;
        Security.allowDomain(loaderInfo.loaderURL);
        Security.allowInsecureDomain(loaderInfo.loaderURL);
        Security.allowDomain(loaderInfo.url);
        Security.allowInsecureDomain(loaderInfo.url);
        new MessagePopup('child=${loaderInfo.applicationDomain.hasDefinition("Example")} mydomain=${ApplicationDomain.currentDomain.hasDefinition("package_4.MessagePopup")} domain=${loaderInfo.applicationDomain.hasDefinition("package_4.MessagePopup")}, parentDomain=${loaderInfo.applicationDomain.parentDomain.hasDefinition("package_4.MessagePopup")}, ${loaderInfo.applicationDomain == loaderInfo.applicationDomain.parentDomain}, 
childAllowsParent=${loaderInfo.childAllowsParent} parentAllowsChild=${loaderInfo.parentAllowsChild}, sameDomain=${loaderInfo.sameDomain}');
        stage.addChild(loaderInfo.content);
    }
    
    function errorHandler(param1:Event)  {
        startFadeOut();
    }
    
    function onProgress(param1:ProgressEvent)  {
        this.progressBar.incProgress(param1.bytesLoaded / param1.bytesTotal);
    }
    
    private function clickClose(param1:MouseEvent) {
        _loader.unloadAndStop();
        startFadeOut();
    }
    
    override public function remove():Dynamic {
        // if(this.loader != null) {
        //     this.loader.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
        //     this.loader.removeEventListener(Event.COMPLETE,this.onComplete);
        //     this.loader.removeEventListener(SuperLoader.d,this.parsedDataHandler);
        //     this.loader.removeEventListener(SuperLoader.e,this.clickClose);
        //     this.loader.remove();
        //     this.loader = null;
        // }
        // this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
        // this.progressBar.remove();
        return super.remove();
    }
}
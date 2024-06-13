package;

import flash.system.SecurityDomain;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.Security;
import flash.utils.ByteArray;
import haxe.crypto.Base64;
import package_4.MessagePopup;
import io.github.fourst4r.modhub.*;
import package_4.Popup;
import ui.ProgressBar;
import flash.net.*;
import flash.events.*;
import flash.display.*;

class InstallingModsPopup extends Popup {
    
    var progressBar:ProgressBar;
    
    var m:UploadingPopupGraphic;
    var _loader:flash.display.Loader;
    var _data:Dynamic;
    var _file:FileReference;
    
    public function new(mods:Array<ModInfo>) {
        this.progressBar = new ProgressBar();
        this.m = new UploadingPopupGraphic();
        super();
        this.m.textBox.text = "sometext";
        addChild(this.m);
        addChild(this.progressBar);
        this.progressBar.x = -100;
        this.progressBar.y = -5;

        _loader = new Loader();
        _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress,false,0,true);
        _loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderComplete,false,0,true);
        _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler,false,0,true);
        m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);
trace("about to");
        new MessagePopup(Security.sandboxType);

        for (mod in mods) {
            // Security.allowDomain(mod.url);
            // new MessagePopup("downloading from "+mod.url);
            // final req = new URLRequest(mod.url);
            // req.requestHeaders.push(new URLRequestHeader("Accept", "application/vnd.github.raw"));

            _file = new FileReference();
            

//             _file.addEventListener(Event.SELECT, e -> {
//                 // "file:///C|/Users/oxyge/Documents/pr2dec/mods/example/bin/example8.swf"
// trace("SELECTED");
//                 final ctx = new LoaderContext();
//                 // ctx.securityDomain = SecurityDomain.currentDomain;
//                 ctx.applicationDomain = ApplicationDomain.currentDomain;
//                 ctx.allowCodeImport = true;
//                 // addChild(_loader);
//                 _loader.loadBytes(_file.data, ctx);
//             }, true);
            _file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, e -> {
                trace("SECURITY ERR");
            });
            _file.addEventListener(Event.SELECT, onSelect);
            _file.addEventListener(Event.COMPLETE, onComplete);
            _file.addEventListener(Event.CANCEL, e -> trace("cancel"));
            _file.addEventListener(ProgressEvent.PROGRESS, e -> trace("progress"));
            _file.addEventListener(IOErrorEvent.IO_ERROR, e -> trace("ioerror"));
            _file.addEventListener(Event.OPEN, e -> trace("open"));
            

            _file.browse();
                

            // final ctx = new LoaderContext();
            // // ctx.securityDomain = SecurityDomain.currentDomain;
            // ctx.applicationDomain = ApplicationDomain.currentDomain;
            // ctx.allowCodeImport = true;
            // // addChild(_loader);
            // _loader.load(req, ctx);
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
package;

import page.HookedPageHolder;
import menu.LoginPage;
import flash.events.UncaughtErrorEvent;
import haxe.io.StringInput;
import flash.events.HTTPStatusEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.errors.SecurityError;
import flash.net.URLLoader;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.display.LoaderInfo;
import flash.events.IOErrorEvent;
import flash.events.Event;
import flash.net.URLRequest;
import flash.display.Loader;
import package_4.MessagePopup;
import flash.system.Security;
import flash.events.MouseEvent;
import flash.Lib;
import io.github.fourst4r.modhub.*;

class ModLoader {
    

    static function main() {
        final stage = Lib.current.stage;

        trace("main");

        Lib.current.stage.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, (e) -> {
            new MessagePopup("ERROR FFS: "+e);
        });

        // flash.Lib.fscommand("exec", "2nd.exe");

        Security.allowDomain("*");
        Security.allowInsecureDomain("*");
        Security.allowDomain("github.com");
        Security.allowInsecureDomain("github.com");

        // final loader = new Loader();
        // loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete,false,0,false);
        // loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandler,false,0,true);
        // final ctx = new LoaderContext();
        // ctx.applicationDomain = ApplicationDomain.currentDomain;
        // ctx.allowCodeImport = true;
        // loader.load(new URLRequest("file:///C:/Users/oxyge/Documents/pr2dec/src/pr2.swf"), ctx);

        Main.instance = new Main();
        Lib.current.stage.addChild(Main.instance);
        
        postInitHook();

    }

    static function postInitHook() {
        Main.pageHolder.remove();
        Main.pageHolder = new HookedPageHolder(new LoginPage());
        Lib.current.stage.addChild(Main.pageHolder);
        Main.pageHolder.addEventListener(Event.CHANGE, e -> {
            trace(e);
        });
    }

    static function onLoaderComplete(param1:Event)  {
        trace("onComplete");
        final loaderInfo:LoaderInfo = param1.target;
        Security.allowDomain(loaderInfo.loaderURL);
        Security.allowInsecureDomain(loaderInfo.loaderURL);
        Security.allowDomain(loaderInfo.url);
        Security.allowInsecureDomain(loaderInfo.url);
        Lib.current.stage.addChild(loaderInfo.content);
        
        loadAllMods();
    }

    static function loadAllMods() {
        final urlloader = new URLLoader();
        urlloader.addEventListener(Event.COMPLETE, (e:Event) -> {
            
            final list = ~/[\r\n]+/g.split(urlloader.data);
            for (mod in list) {
                loadMod(mod);
            }
            
        },false,0);
        urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler,false,0,true);
        urlloader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler,false,0,true);
        urlloader.load(new URLRequest("file:///C:/Users/oxyge/Documents/pr2dec/bin/mods.txt"));
    }

    static function loadMod(uri:String) {
        trace("Loading mod "+uri);
        final loader = new Loader();
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, (e) -> {
            trace("Loaded mod successfully "+uri);
            final loaderInfo:LoaderInfo = e.target;
            Security.allowDomain(loaderInfo.loaderURL);
            Security.allowInsecureDomain(loaderInfo.loaderURL);
            Security.allowDomain(loaderInfo.url);
            Security.allowInsecureDomain(loaderInfo.url);
            loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, (e) -> {
                new MessagePopup("ERROR FFS: "+e);
            });
            Lib.current.stage.addChild(loaderInfo.content);
            
        });
        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandler,false,0,true);
        final ctx = new LoaderContext();
        ctx.applicationDomain = ApplicationDomain.currentDomain;
        ctx.allowCodeImport = true;
        loader.load(new URLRequest(uri), ctx);
    }

    static function errorHandler(param1)  {
        trace("error: "+param1);
        // startFadeOut();
    }

    // For some bizarre reason this *has* to be inline or else it can't find fl.controls::Button.
    // static function mkModsButton() {
    //     final classes = ApplicationDomain.currentDomain.getQualifiedDefinitionNames();
    //     classes.sort(Reflect.compare);
    //     new MessagePopup(classes.join("\n"));
        
    //     final b = Type.createInstance(Type.resolveClass("fl.controls::Button"), []);
    //     // final b = new fl.controls.Button();
    //     b.x = 10;
    //     b.y = 10;
    //     b.label = "Mods";
    //     b.addEventListener(MouseEvent.CLICK, e -> new ModMenu(new ModHub()));
    //     return b;
    //     return null;
    // }
}
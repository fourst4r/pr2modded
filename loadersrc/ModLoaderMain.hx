package;

import api.Game;
import haxe.CallStack;
import haxe.io.Path;
import haxe.Json;
import flash.net.URLRequestHeader;
import modding.*;
import page.HookedPageHolder;
import menu.LoginPage;
import flash.events.UncaughtErrorEvent;
import flash.events.SecurityErrorEvent;
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
import flash.Lib;

class ModLoaderMain {
    #if debug
    static inline final MODS_LOCATION = "file:///C:/Users/oxyge/Documents/pr2dec/mods/";
    #else
    static inline final MODS_LOCATION = "https://github.com/fourst4r/pr2mods/raw/main/";
    #end

    static function main() {

        // Security.allowDomain("*");
        // Security.allowInsecureDomain("*");
        // Security.allowDomain("github.com");
        // Security.allowInsecureDomain("github.com");

        // final loader = new Loader();
        // loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete,false,0,false);
        // loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandler,false,0,true);
        // final ctx = new LoaderContext();
        // ctx.applicationDomain = ApplicationDomain.currentDomain;
        // ctx.allowCodeImport = true;
        // loader.load(new URLRequest("file:///C:/Users/oxyge/Documents/pr2dec/src/pr2.swf"), ctx);

        // Initialize the game
        // Main.instance = new Main();
        // Lib.current.stage.addChild(Main.instance);
        Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, (e:UncaughtErrorEvent) -> {
            // THIS ONE CAUGHT AN ERROR BEFORE! YIPPEEE!
            new MessagePopup("Uncaught Error: "+e.error);
        });
        Lib.current.stage.addChild(new Main());

        // Hook useful classes
        hookPageHolder();

        // Load the mods!
        // loadAllMods();
        // loadModList();
        bootstrap();

    }

    static function hookPageHolder() {
        Main.pageHolder.remove();
        Main.pageHolder = new HookedPageHolder(new LoginPage());
        Main.stage.addChildAt(Main.pageHolder, 0);
    }

    // static function onLoaderComplete(param1:Event) {
    //     final loaderInfo:LoaderInfo = param1.target;
    //     Security.allowDomain(loaderInfo.loaderURL);
    //     Security.allowInsecureDomain(loaderInfo.loaderURL);
    //     Security.allowDomain(loaderInfo.url);
    //     Security.allowInsecureDomain(loaderInfo.url);
    //     Lib.current.stage.addChild(loaderInfo.content);
        
        
    //     loadAllMods();
    // }

    static function loadModList() {
        final urlloader = new URLLoader();
        
        urlloader.addEventListener(Event.COMPLETE, (e:Event) -> {
            final modlist:Array<ModInfo> = Json.parse(urlloader.data);
            final modhub = modlist.find(m -> m.name == "Modhub");
            trace("modhub="+modhub);
            loadMod3(modhub, modlist);
        });
        urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler,false,0,true);
        urlloader.addEventListener(IOErrorEvent.IO_ERROR, e -> {
            new MessagePopup("Failed to load modlist.");
        });
        final req = new URLRequest(MODS_LOCATION + "modlist.json");
        req.requestHeaders.push(new URLRequestHeader("pragma", "no-cache"));
        urlloader.load(req);
    }

    // static function loadAllMods() {
    //     final urlloader = new URLLoader();
    //     urlloader.addEventListener(Event.COMPLETE, (e:Event) -> {
            
    //         final list = ~/[\r\n]+/g.split(urlloader.data);
    //         for (mod in list) {
    //             loadMod(mod);
    //         }

    //     },false,0);
    //     urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler,false,0,true);
    //     urlloader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler,false,0,true);
    //     final req = new URLRequest("file:///C:/Users/oxyge/Documents/pr2dec/bin/mods3.txt?v="+Math.random());
    //     req.requestHeaders.push(new URLRequestHeader("pragma", "no-cache"));
    //     urlloader.load(req);
    // }

    static function bootstrap() {
        final loader = new modding.ModLoader();
        loader.addWeakListener(Event.COMPLETE, (e:Event) -> {
            Main.stage.addChild(loader.getContent());
        });
        loader.addWeakListener(IOErrorEvent.IO_ERROR, errorHandler);
        final uri = Path.join([MODS_LOCATION, "modhub.swf"]);
        final ctx = new ModContext({name: "Modhub", file: "modhub.swf", pkg: "modhub", "version": "", description: "", author: ""}, [], MODS_LOCATION);
        loader.load(uri, ctx);
    }

    static function loadMod3(info:ModInfo, allMods:Array<ModInfo>) {
        final loader = new modding.ModLoader();
        loader.addWeakListener(Event.COMPLETE, (e:Event) -> {
            Main.stage.addChild(loader.getContent());
        });
        loader.addWeakListener(IOErrorEvent.IO_ERROR, errorHandler);
        final uri = Path.join([MODS_LOCATION, info.file]);
        final ctx = new ModContext(info, allMods, MODS_LOCATION);
        loader.load(uri, ctx);
    }

    // static function loadMod2(info:ModInfo, allMods:Array<ModInfo>) {
    //     trace("Loading mod "+info.name);
    //     final loader = new Loader();
    //     loader.contentLoaderInfo.addEventListener(Event.COMPLETE, (e) -> {
    //         trace("Loaded mod successfully "+info.name);
    //         final loaderInfo:LoaderInfo = e.target;
    //         Security.allowDomain(loaderInfo.loaderURL);
    //         Security.allowInsecureDomain(loaderInfo.loaderURL);
    //         Security.allowDomain(loaderInfo.url);
    //         Security.allowInsecureDomain(loaderInfo.url);
    //         loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, (e:UncaughtErrorEvent) -> {
    //             trace("UNCAUGHT ERROR! "+e.error);
    //             new MessagePopup("inmodloaderERROR FFS: "+e.error);
    //         });
    //         Lib.current.stage.addChild(loaderInfo.content);
        
    //         try {
    //             final modClass = loaderInfo.applicationDomain.getDefinition('${info.pkg}::Mod');
    //             final mod = untyped __new__(__as__(modClass, Class));
    //             mod.init(new ModContext(info, allMods, MODS_LOCATION));
    //         } catch (e:Dynamic) {
    //             trace('Incompatible mod ${info.name}: '+Std.string(e));
    //         }

    //     });

    //     loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,e -> {
    //         new MessagePopup("Failed to load Modhub.");
    //     });
    //     final ctx = new LoaderContext();
    //     ctx.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
    //     ctx.allowCodeImport = true;
    //     final uri = Path.join([MODS_LOCATION, info.file]);
    //     trace("about to load "+uri);
    //     loader.load(new URLRequest(uri), ctx);
    // }

    // static function loadMod(uri:String) {
    //     trace("Loading mod "+uri);
    //     final loader = new Loader();
    //     loader.contentLoaderInfo.addEventListener(Event.COMPLETE, (e) -> {
    //         trace("Loaded mod successfully "+uri);
    //         final loaderInfo:LoaderInfo = e.target;
    //         Security.allowDomain(loaderInfo.loaderURL);
    //         Security.allowInsecureDomain(loaderInfo.loaderURL);
    //         Security.allowDomain(loaderInfo.url);
    //         Security.allowInsecureDomain(loaderInfo.url);
    //         loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, (e) -> {
    //             new MessagePopup("ERROR FFS: "+e);
    //         });
    //         Lib.current.stage.addChild(loaderInfo.content);
        
    //         final mod:IMod = untyped __new__(__as__(loaderInfo.applicationDomain.getDefinition("modhub::Mod"), Class));
    //         mod.enable();

    //     });

    //     loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandler,false,0,true);
    //     final ctx = new LoaderContext();
    //     ctx.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
    //     ctx.allowCodeImport = true;
    //     loader.load(new URLRequest(uri), ctx);
    // }

    static function errorHandler(param1:IOErrorEvent)  {
        trace("error: "+param1.toString());
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
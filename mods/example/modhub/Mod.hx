package modhub;

import api.Game;
import fl.controls.Button;
import flash.errors.IOError;
import flash.net.URLRequestHeader;
import flash.events.SecurityErrorEvent;
import haxe.Json;
import flash.net.URLLoader;
import package_18.LoadoutsPopup;
import haxe.io.Path;
// import api.*;
import modding.*;
import flash.events.UncaughtErrorEvent;
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

final class Mod extends modding.ModBase {
    var _modsLoaded:Array<ModLoader>;

    public override function init(ctx:ModContext) {
        super.init(ctx);
        _modsLoaded = [];
        // final mods = ctx.allMods.copy();
        // mods.remove(ctx.current); // exclude modhub
        // new modhub.ui.ModMenu2(cast mods);
        loadModList();
        
        // Game.pageHolder.getCurrentPage().addChild(new Button());
    }

    function loadMod(mod:ModInfo) {
        final loader = new ModLoader();
        loader.addEventListener(Event.COMPLETE, onModLoaded);
        loader.addEventListener(IOErrorEvent.IO_ERROR, onModLoaderError);
        final uri = Path.join([_ctx.modsLocation, mod.file]);
        loader.load(uri, new ModContext(mod, [], _ctx.modsLocation));
        _modsLoaded.push(loader);
    }

    function onModLoaded(e:Event) {
        final loader:ModLoader = e.target;
        loader.getMod().enable();
        Game.getStage().addChild(loader.getContent());
    }

    function onModLoaderError(e:IOErrorEvent) {
        _modsLoaded.remove(e.target);
        new MessagePopup("Failed to load mod.");
    }

    function loadModList() {
        final urlloader = new URLLoader();
        urlloader.addEventListener(Event.COMPLETE, onLoadModList);
        urlloader.addEventListener(IOErrorEvent.IO_ERROR, onError);
        final req = new URLRequest(_ctx.modsLocation + "modlist.json");
        req.requestHeaders.push(new URLRequestHeader("pragma", "no-cache"));
        urlloader.load(req);
    }

    function onLoadModList(e:Event) {
        final urlloader:URLLoader = e.target;
        
        var modlist:Array<ModInfo> = Json.parse(urlloader.data);
        modlist = modlist.filter(m -> m.name != _ctx.current.name); // exclude modhub
        new modhub.ui.ModMenu2(cast modlist).onClose = function(selected) {
            for (mod in selected) {
                loadMod(mod);
            }
        };

        urlloader.removeEventListener(Event.COMPLETE, onLoadModList);
        urlloader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
    }

    function onError(e) {
        new MessagePopup("Failed to load modlist.");
    }

    public override function enable() {
        trace("modhub starting");
        // loadMod("file:///C:/Users/oxyge/Documents/pr2dec/mods/example/bin/skinning.swf");
    }

    public override function disable() {
    }

    // function loadMod(info:ModInfo, allMods:Array<ModInfo>) {
    //     trace("Loading mod "+info.name);
    //     final loader = new Loader();
    //     loader.contentLoaderInfo.addEventListener(Event.COMPLETE, (e) -> {
    //         trace("Loaded mod successfully "+info.name);
    //         final loaderInfo:LoaderInfo = e.target;
    //         Security.allowDomain(loaderInfo.loaderURL);
    //         Security.allowInsecureDomain(loaderInfo.loaderURL);
    //         Security.allowDomain(loaderInfo.url);
    //         Security.allowInsecureDomain(loaderInfo.url);
    //         loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, (e) -> {
    //             new MessagePopup("inmodhub ERROR FFS: "+e);
    //         });
    //         Lib.current.stage.addChild(loaderInfo.content);
            
    //         final mod:IMod = untyped __new__(__as__(loaderInfo.applicationDomain.getDefinition("skinning::Mod"), Class));
    //         mod.init(new ModContext(info, allMods, _ctx.modsLocation));
    //         mod.enable();

    //     });
    //     loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandler,false,0,true);
    //     final ctx = new LoaderContext();
    //     ctx.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
    //     ctx.allowCodeImport = true;
    //     final uri = Path.join([_ctx.modsLocation, info.file]);
    //     trace("about to load "+uri);
    //     loader.load(new URLRequest(uri), ctx);
    // }

    static function errorHandler(param1:IOErrorEvent)  {
        trace("error: "+param1);
    }
}
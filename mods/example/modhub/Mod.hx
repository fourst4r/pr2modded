package modhub;

import api.Game;
import flash.net.URLRequestHeader;
import haxe.Json;
import flash.net.URLLoader;
import haxe.io.Path;
import modding.*;
import flash.events.IOErrorEvent;
import flash.events.Event;
import flash.net.URLRequest;
import package_4.MessagePopup;

final class Mod extends modding.ModBase {
    var _modsLoaded:Array<ModLoader>;

    public override function init(ctx:ModContext) {
        super.init(ctx);
        _modsLoaded = [];
        
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
    }

    public override function disable() {
    }

    static function errorHandler(param1:IOErrorEvent)  {
        trace("error: "+param1);
    }
}
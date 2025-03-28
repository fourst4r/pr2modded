package;

import flash.events.UncaughtErrorEvent;
import haxe.io.Path;
import haxe.Json;
import modding.*;
import menu.LoginPage;
import page.HookedPageHolder;
import flash.net.URLRequestHeader;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.events.IOErrorEvent;
import flash.events.Event;
import flash.net.URLRequest;
import package_4.MessagePopup;
import flash.Lib;

final class ModLoaderMain {
    #if debug
    static var MODS_LOCATION = "file:///" + Macro.cwd() + "/mods/";
    #else
    static final MODS_LOCATION = "https://github.com/fourst4r/pr2mods/raw/main/";
    #end

    static function main() {
        Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, (e:UncaughtErrorEvent) -> {
            // THIS ONE CAUGHT AN ERROR BEFORE! YIPPEEE!
            new MessagePopup("Uncaught Error: "+e.error);
        });
        Lib.current.stage.addChild(new Main());
        Lib.fscommand("exec", "echo.bat");
        // Hook useful classes
        hookPageHolder();
        hookCreateGame();

        bootstrap();
    }

    static function hookCreateGame() {
        Main.commandHandler.defineCommand("startGame", api.Game.onCreateGame);
    }

    static function hookPageHolder() {
        Main.pageHolder.remove();
        Main.pageHolder = new HookedPageHolder(new LoginPage());
        Main.stage.addChildAt(Main.pageHolder, 0);
    }

    static function loadModList() {
        final urlloader = new URLLoader();
        urlloader.addEventListener(Event.COMPLETE, (e:Event) -> {
            final modlist:Array<ModInfo> = Json.parse(urlloader.data);
            final modhub = modlist.find(m -> m.name == "Modhub");
            loadMod(modhub, modlist);
        });
        urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler,false,0,true);
        urlloader.addEventListener(IOErrorEvent.IO_ERROR, e -> {
            new MessagePopup("Failed to load modlist.");
        });
        final req = new URLRequest(MODS_LOCATION + "modlist.json");
        req.requestHeaders.push(new URLRequestHeader("pragma", "no-cache"));
        urlloader.load(req);
    }

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

    static function loadMod(info:ModInfo, allMods:Array<ModInfo>) {
        final loader = new modding.ModLoader();
        loader.addWeakListener(Event.COMPLETE, (e:Event) -> {
            Main.stage.addChild(loader.getContent());
        });
        loader.addWeakListener(IOErrorEvent.IO_ERROR, errorHandler);
        final uri = Path.join([MODS_LOCATION, info.file]);
        final ctx = new ModContext(info, allMods, MODS_LOCATION);
        loader.load(uri, ctx);
    }

    static function errorHandler(param1:IOErrorEvent)  {
        new MessagePopup("error: "+param1.toString());
    }
}
package modding;

import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.Event;
import flash.display.LoaderInfo;
import flash.system.LoaderContext;
import flash.system.ApplicationDomain;
import flash.net.URLRequest;
import flash.display.Loader;

class ModLoader extends EventDispatcher {
    public function getContent()
        return _loader.content;

    public function getMod()
        return _mod;
    
    var _loader:Loader;
    var _ctx:ModContext;
    var _mod:IMod;

    public function new() {
        super();
        _loader = new Loader();
        _loader.contentLoaderInfo.addWeakListener(Event.COMPLETE, onComplete);
        _loader.contentLoaderInfo.addWeakListener(IOErrorEvent.IO_ERROR, onError);
    }

    public function load(uri:String, ctx:ModContext) {
        _ctx = ctx;
        final loaderCtx = new LoaderContext();
        // loaderCtx.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
        loaderCtx.applicationDomain = ApplicationDomain.currentDomain;
        loaderCtx.allowCodeImport = true;
        // trace("loading uri="+uri);
        _loader.load(new URLRequest(uri), loaderCtx);
    }

    function onComplete(e:Event) {
        // trace("Loaded mod successfully "+_ctx.current?.name);
        final loaderInfo:LoaderInfo = e.target;

        try {
            final modClass = loaderInfo.applicationDomain.getDefinition('${_ctx.current.pkg}::Mod');
            _mod = untyped __new__(__as__(modClass, Class));
            _mod.init(_ctx);
        } catch (e:Dynamic) {
            trace('Incompatible mod ${_ctx.current?.name}: '+Std.string(e));
        }

        dispatchEvent(new Event(Event.COMPLETE));
    }

    function onError(e) {
        trace("GAY ERR: "+e);
    }

    public function unload() {
        _loader.unloadAndStop();
    }
}
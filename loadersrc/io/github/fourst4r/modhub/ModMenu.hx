package;

import io.github.fourst4r.modhub.*;
import haxe.Http;
import package_4.MessagePopup;
import flash.events.SecurityErrorEvent;
import flash.errors.SecurityError;
import flash.utils.ByteArray;
import flash.net.URLRequest;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import fl.controls.listClasses.ListData;
import fl.controls.listClasses.ICellRenderer;
import fl.data.DataProvider;
import flash.events.MouseEvent;
import fl.controls.Button;
import package_4.Popup;
import fl.events.SliderEvent;
import flash.display.Sprite;
import flash.display.Loader;

class ModMenu extends Popup {
    var _modList:CheckBoxList;
    var _modHub:ModHub;

    public function new(modHub:ModHub) {
        super();


        final bg = new ShadowBG();
        // bg.width = 350;
        // bg.height = 300;
        bg.x = -bg.width/2;
        bg.y = -bg.height/2;
        addChild(bg);
        
        final btnOk = new Button();
        btnOk.x = bg.width/2 - btnOk.width/2;
        btnOk.y = bg.height - btnOk.height - 5;
        btnOk.label = "OK";
        btnOk.addEventListener(MouseEvent.CLICK, btnOk_CLICK, false, 0, true);
        bg.addChild(btnOk);

        _modList = new CheckBoxList();
        _modList.x = 4;
        _modList.y = 4;
        _modList.setSize(bg.width-2, bg.height/2);
        bg.addChild(_modList);

        _modHub = modHub;
        _modHub.allMods(onMods, onError);
    }

    function onMods(mods:Array<ModInfo>) {
        final data = new DataProvider();
        for (mod in mods) {
            final dmod:Dynamic = mod;
            dmod.label = mod.name;
            data.addItem(dmod);
        }
        _modList.dataProvider = data;
    }

    function onError(err) {
        new MessagePopup("Error loading mod list: "+err);
    }

    function btnOk_CLICK(e) {
        startFadeOut();

        // var url:String = "http://www.helpexamples.com/flash/images/image2.jpg";
        // var urlRequest:URLRequest = new URLRequest(url);
        // var loader:Loader = new Loader();
        // loader.load(urlRequest);
        // addChild(loader);

        final enabledMods:Array<ModInfo> = cast _modList.dataProvider.toArray().filter(x -> x.selected);
        new InstallingModsPopup(enabledMods);

        // var url:String = "https://github.com/fourst4r/pr2mods/raw/main/red-earth.swf";
        // var urlRequest:URLRequest = new URLRequest(url);
        // var loader:Loader = new Loader();
        // loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, e -> new MessagePopup(e));
        // loader.load(urlRequest);
        // addChild(loader);

        // var myURLReq:URLRequest = new URLRequest();
        // myURLReq.url = "https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/URLRequest.html";
        // var myURLLoader:URLLoader = new URLLoader();
        // myURLLoader.dataFormat = URLLoaderDataFormat.TEXT;
        // function onC(e) {

        //     var someLoader:Loader = new Loader();
        //     addChild(someLoader);
        //     someLoader.loadBytes((myURLLoader.data)); 
        // }
        // myURLLoader.addEventListener("complete", onC);
        // myURLLoader.addEventListener(Url)
        
        // myURLLoader.load(myURLReq);
        
        

    }
}
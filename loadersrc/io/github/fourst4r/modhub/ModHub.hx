package;

import haxe.Json;
import haxe.Http;

private typedef ModListResponse = {
    sha:String,
    url:String,
    tree:Array<{
        path:String,
        mode:String,
        type:String,
        sha:String,
        size:Int,
        url:String,
    }>,
    truncated:Bool,
}

class ModHub {
    public function new() {
    }

    public function allMods(onData:Array<ModInfo>->Void, onError) {
        final h = new Http("https://api.github.com/repos/fourst4r/pr2mods/git/trees/main");
        h.onData = data -> {
            try {
                final resp:ModListResponse = Json.parse(data);
                final infos = resp.tree.map(x -> {
                    name: x.path,
                    url: x.url,
                    size: x.size
                });
                onData(infos);
            } catch (ex) {
                onError(ex.message);
            }
        };
        h.onError = onError;
        h.request();
    }

    public function fetchMod(mod:ModInfo) {

    }
}
package;

import haxe.io.Path;

macro function cwd() {
    return macro $v{Path.normalize(Sys.getCwd())};
}
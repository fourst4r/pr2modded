package modding;

abstract class ModBase implements IMod {
    var _ctx:ModContext;

    public function init(ctx:ModContext) {
        _ctx = ctx;
    }
    
    public function enable() {}
    public function disable() {}
}
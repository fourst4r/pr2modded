package;

class ModBase implements IMod {
    var _ctx:ModContext;

    public function new(ctx:ModContext) {
        _ctx = ctx;
    }

    public function enable() {}
    
    public function disable() {}
}
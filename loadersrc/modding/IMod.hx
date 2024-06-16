package modding;

interface IMod {
    function init(ctx:ModContext):Void;
    // function deinit():Void;
    function enable():Void;
    function disable():Void;
}
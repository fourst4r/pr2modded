package fl.controls.listClasses;

import flash.utils.Object;

extern interface ICellRenderer {
    var y(get, set):Float;
    var x(get, set):Float;
    function setSize(param1:Float, param2:Float):Void;
    var listData(get, set):ListData;
    var data(get, set):Object;
    var selected(get, set):Bool;
    function setMouseState(param1:String):Void;
}
package modhub;

// import flash.errors.Error;
// import flash.events.MouseEvent;
// import flash.utils.Object;
// import fl.controls.CheckBox;
// import fl.controls.listClasses.ListData;
// import fl.controls.listClasses.ICellRenderer;

// private class CheckBoxCellRenderer extends CheckBox implements ICellRenderer {
//     @:flash.property public var data(get, set):Dynamic;
//     @:flash.property public var listData(get, set):ListData;

//     var _listData:ListData;
//     var _data:Dynamic;
//     var _sel:Bool;

//     function get_data():Dynamic {
//         trace("get_data");
//         // _data.selected = _sel;
//         return _data;
//     }
//     function set_data(v):Dynamic {
//         trace("set_data");
//         // label = v.label;
//         // set_selected(v.selected ?? false);
//         return _data = v;
//     }

//     function get_listData() {
//         trace("get_listdata");
//         return _listData;
//     }
//     function set_listData(v) {
//         trace("set_listData");
//         return _listData = v;
//     }

//     // override function get_selected()
//     //     return _sel;
//     // override function set_selected(v) {
//     //     _sel = v;
//     //     return super.selected = _sel;
//     // }

// }

// class CheckBoxList extends fl.controls.List {
//     public function new() {
//         super();
//         trace("new CheckBoxList");
//         // this.addEventListener(MouseEvent.CLICK, e -> { e.ctrlKey = true; }, true);
//         // allowMultipleSelection = true;
//         // setStyle("cellRenderer", CheckBoxCellRenderer);

//     }
// }
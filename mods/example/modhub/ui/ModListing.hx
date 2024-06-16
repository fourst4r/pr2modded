package modhub.ui;

import flash.events.MouseEvent;
import fl.controls.CheckBox;
import fl.controls.Button;
import ui.*;

class ModListing extends Class229 {
    var _m:ModListingGraphic;

    public final modInfo:ModInfo;

    public function new(mod:ModInfo) {
        _m = new ModListingGraphic();
        super(_m);
        modInfo = mod;
        _m.labelName.text = mod.name;
        _m.labelDescription.text = mod.description;
        _m.checkSelected.addEventListener(MouseEvent.CLICK, e -> {
            setSelected(_m.checkSelected.selected);
        }, false, 0, true);

        addChild(_m);

    }

    function setSelected(v) {
        method_368(v);
    }

}
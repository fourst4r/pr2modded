package modhub.ui;

import flash.events.MouseEvent;
import package_4.GetLevelsPopup;

class ModMenu2 extends GetLevelsPopup {
    var _mods:Array<ModInfo>;

    public dynamic function onClose(selectedMods:Array<ModInfo>) {}

    public function new(mods:Array<ModInfo>) {
        super();
        _mods = mods;
        setItemHeight(68);
        m.titleBox.text = "-- Load Mods --";
        m.load_bt.enabled = true;
        m.load_bt.addEventListener(MouseEvent.CLICK, onLoadMods, false,0,true);
        hideLoadingGraphic();
        populate();
    }

    function onLoadMods(e) {
        startFadeOut();
        
        var selected = [];
        for (mod in listings) {
            if (mod.getSelected()) {
                selected.push(cast(mod, ModListing).modInfo);
            } else {

            }
        }

        onClose(selected);
    }

    function getSelectedMods() {
        var selected = [];
        for (mod in listings) {
            if (mod.getSelected())
                selected.push(cast(mod, ModListing).modInfo);
        }
        return selected;
    }

    function populate() {
        for (mod in _mods) {
            method_455(cast new ModListing(mod));
        }
    }

    function setItemHeight(h:Int) {
        var_454 = h;
    }
}
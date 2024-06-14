package levelEditor;

import flash.net.URLVariables;

class HookedLevelEditor extends levelEditor.LevelEditor {
    public function new(vars:URLVariables, isMod:Bool = false, reportsMode:Bool = false) {
        super(vars, isMod, reportsMode);
    }
}
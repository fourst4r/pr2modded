package;

import levelEditor.LevelEditor;

class BetterLevelEditor extends LevelEditor {
    public function new(le:LevelEditor) {
        super(le.variables, le.isMod, le.reportsMode);
        addChild(new fl.controls.Button());
    }


}
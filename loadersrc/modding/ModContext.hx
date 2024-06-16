package modding;

class ModContext {
    public final allMods:Array<ModInfo>;
    public final current:ModInfo;
    public final modsLocation:String;

    public function new(current:ModInfo, all:Array<ModInfo>, modsLocation:String) {
        this.current = current;
        this.allMods = all;
        this.modsLocation = modsLocation;
    }
}
package api;

import flash.display.Stage;

final class Game {
    // public static var build(get, never):String;
    public static function getBuild() 
        return Main.build;

    // @:flash.property public static var stage(get, never):Stage;
    public static function getStage() 
        return Main.stage;
    
    // @:flash.property public static var pageHolder(get, never):page.PageHolder;
    public static function getPageHolder()
        return Main.pageHolder;

    public static function accountInfo() {
        if (Main.userId == 0)
            return null;
        return {
            group: Main.group,
            userId: Main.userId,
            hasEmail: Main.hasEmail,
            token: Main.token,
            remember: Main.remember,
            guild: Main.guild,
            guildOwner: Main.guildOwner,
            guildName: Main.guildName,
            emblem: Main.emblem,
            userName: Main.userName,
            isSpecialUser: Main.isSpecialUser,
            isTempMod: Main.isTempMod,
            isTrialMod: Main.isTrialMod,
            isPrizer: Main.isPrizer,
        };
    }
}
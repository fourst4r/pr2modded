package api;

final class Game {
    public static var build(get, never):String;
    static function get_build() return Main.build;

    public static function accountInfo() {
        if (Main.userId == 0)
            return null;
        return {
            group: Main.group,
            userId: Main.userId,
            hasEmail: Main.hasEmail,
            hasAnt: Main.hasAnt,
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
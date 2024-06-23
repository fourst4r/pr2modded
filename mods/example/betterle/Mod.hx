package betterle;

import com.jiggmin.data.Settings;
import ui.LoginPageMenuButton;
import page.Page;
import levelEditor.LevelEditor;
import page.PageChangeEvent;
import api.Game;

final class Mod extends modding.ModBase {
    
    public override function enable() {
        Game.getPageHolder().addEventListener(PageChangeEvent.PAGE_CHANGE, function(e:PageChangeEvent) {
            if (e.to is LevelEditor && !(e.to is BetterLevelEditor)) {
                e.preventDefault();
                final le = cast(e.to, LevelEditor);
                Game.getPageHolder().changePage(new BetterLevelEditor(le));
            } else {
                modifyLoginPage(e.to);
            }
        });

        Settings.init("Guest");
        modifyLoginPage(Game.getPageHolder().getCurrentPage());
    }

    /**
        Adds a LE shortcut to the login page.
    **/
    function modifyLoginPage(page:Page) {
        if (!(page is menu.LoginPage)) {
            return;
        }
        final page = cast(page, menu.LoginPage);
        final prevButton = page.buttons[3] ?? return;
        page.removeChild(prevButton);
        page.buttons[3] = new LoginPageMenuButton("Level Editor", function(e) {
            Game.getPageHolder().changePage(new BetterLevelEditor());
        });
        page.buttons[3].x = prevButton.x;
        page.buttons[3].y = prevButton.y;
        page.addChild(page.buttons[3]);
    }
}
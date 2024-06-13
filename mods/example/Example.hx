package;

import page.Page;
import menu.LoginPage;
import flash.errors.ReferenceError;
import page.PageHolder;
import flash.events.Event;
import flash.system.Security;

class Example {
    public static function main() {
        Security.allowDomain("*");
        Security.allowInsecureDomain("*");
        // Example.lessgo();
        // MyLoader.yeah();
        new package_4.MessagePopup("Loaded!!!!!");

        Main.pageHolder.remove();
        Main.pageHolder = new page.MyPageHolder(new LoginPage());
        Main.instance.addChild(Main.pageHolder);
        // Main.pageHolder.addEventListener()
    }

    public static function lessgo() {
        // trace(Security.pageDomain);
        // trace(Security.sandboxType);
        // Security.showSettings();
    }
}


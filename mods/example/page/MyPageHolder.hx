package page;

import flash.errors.ReferenceError;
import page.*;

class MyPageHolder extends page.PageHolder {
    public dynamic function onAfterChange(before:Page, after:Page) {
        try {
            after = untyped this["currentPage"];
            trace("CHANGED "+before+" -> "+after);
        } catch (e:ReferenceError) {
            trace("referr="+e);
        }
    }

    public function new(page:Page) {
        super(page);
    }

    public override function changePage(p1:Page):Dynamic {
        final before = getCurrentPage();
        super.changePage(p1);
        onAfterChange(before, p1);
        return null;
    }
}
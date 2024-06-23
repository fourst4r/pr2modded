package page;

import flash.events.Event;

final class PageChangeEvent extends flash.events.Event {
    public static inline final PAGE_CHANGE = "pageChange";

    public final from:Page;
    public final to:Page;

    public function new(from:Page, to:Page) {
        super(PAGE_CHANGE, false, true);
        this.from = from;
        this.to = to;
    }
}
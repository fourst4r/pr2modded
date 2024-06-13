package page;

import flash.events.Event;

final class PageChangeEvent extends flash.events.Event {
    public final from:Page;
    public final to:Page;

    public function new(from:Page, to:Page) {
        super(Event.CHANGE, false, true);
        this.from = from;
        this.to = to;
    }
}
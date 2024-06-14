package page;

class HookedPageHolder extends page.PageHolder {
    public function new(page:Page) {
        super(page);
    }

    public override function changePage(to:Page):Dynamic {
        final from = this.currentPage;
        if (dispatchEvent(new PageChangeEvent(from, to))) {
            super.changePage(to);
        }
        return null;
    }
}

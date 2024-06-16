# pr2modded
Platform Racing 2, with mods.

# Authoring mods
PR2's decompiled source code is provided as reference for mods in `clientsrc/`.

# Debugging ModLoader
Go to [Flash Global Security Settings panel](https://www.macromedia.com/support/documentation/en/flashplayer/help/settings_manager04.html#117502) and add the repository folder as a trusted location.

Now you can get stack traces with errors, just run `loader.swf` directly with a Flash debug projector.

Note: You need Flash installed on your PC to access the security settings panel, install it [here](https://archive.org/download/flashplayer32_0r0_371_win) (or [here](https://drive.google.com/file/d/1JFhniRKz7J9AZvu-73n7wRyNEbl5MdzI/view?usp=sharing)) then use a Flash-enabled browser like Basilisk or [Pale Moon](https://www.palemoon.org/download.shtml) to visit the website.

TODO: Automate this process by writing to `trustedPaths` at `%AppData%\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys\settings.sol`.
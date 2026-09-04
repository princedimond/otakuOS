{ ... }:
{
  flake.modules.homeManager.niri = {
    programs.niri.settings.binds = {
      "Mod+D".action.spawn = [
        "noctalia"
        "msg"
        "panel-toggle"
        "launcher"
      ];
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Shift+1".action.move-window-to-workspace = [
        { focus = false; }
        "terminal-apps"
      ];
      "Mod+Shift+2".action.move-window-to-workspace = [
        { focus = false; }
        "web-browsers"
      ];
      "Mod+Shift+3".action.move-window-to-workspace = [
        { focus = false; }
        "chat-apps"
      ];
      "Mod+Shift+4".action.move-window-to-workspace = [
        { focus = false; }
        "notetaking-apps"
      ];
      "Mod+Shift+5".action.move-window-to-workspace = [
        { focus = false; }
        "productivity-apps"
      ];
      "Mod+Shift+6".action.move-window-to-workspace = [
        { focus = false; }
        "media-apps"
      ];
      "Mod+Shift+7".action.move-window-to-workspace = [
        { focus = false; }
        "misc-apps"
      ];
      "Mod+Shift+8".action.move-window-to-workspace = [
        { focus = false; }
        "misc-apps"
      ];
      "Mod+Shift+9".action.move-window-to-workspace = [
        { focus = false; }
        "misc-apps"
      ];
      "Mod+Shift+S".action.screenshot = {
        show-pointer = false;
      };
      "Mod+Q".action.close-window = {

      };
      "Mod+Tab".action.next-window = {

      };
      "Alt+Tab".action.next-window = {

      };
      "Mod+Shift+Tab".action.previous-window = {

      };
      "Alt+Shift+Tab".action.previous-window = {

      };
    };
  };
}

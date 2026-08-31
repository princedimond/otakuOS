{ ... }:
{
  flake.modules.homeManager.niri = {
    programs.niri.settings.binds = {
      "Mod+D".action.spawn = ["noctalia" "msg" "panel-toggle" "launcher"];
      "Mod+1".action.focus-workspace = 1;
      "Mod+Shift+1".action.move-window-to-workspace = [ { focus = false; } "chat-apps" ];
    };
  };
}

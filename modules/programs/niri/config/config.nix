{ ... }:
{
  flake.modules.homeManager.niri = {
    xdg.configFile."niri/config.kdl".source = ./kdls/config.kdl;
    xdg.configFile."niri/binds.kdl".source = ./kdls/binds.kdl;
    xdg.configFile."niri/monitors.kdl".source = ./kdls/monitors.kdl;
    xdg.configFile."niri/layout.kdl".source = ./kdls/layout.kdl;
    xdg.configFile."niri/autostart.kdl".source = ./kdls/autostart.kdl;
    xdg.configFile."niri/general.kdl".source = ./kdls/general.kdl;
    xdg.configFile."niri/input.kdl".source = ./kdls/input.kdl;
    xdg.configFile."niri/windowrules.kdl".source = ./kdls/windowrules.kdl;
    xdg.configFile."niri/animations.kdl".source = ./kdls/animations.kdl;
    xdg.configFile."noctalia/noctalia-config.toml".source = ./noctalia-config.toml;
  };
}

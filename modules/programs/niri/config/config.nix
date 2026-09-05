{ ... }:
{
  flake.modules.homeManager.niri = {
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
  };
}

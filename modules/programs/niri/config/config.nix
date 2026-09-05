{ ... }:
{
  flake.modules.homeManager.niri = {
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
    xdg.configFile."niri/noctalia.kdl".source = ./noctalia.kdl;
  };
}

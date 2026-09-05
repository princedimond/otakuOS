{ ... }:
{
  flake.modules.homeManager.niri = {
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
    xdg.configFile."noctalia/noctalia-config.toml".source = ./noctalia-config.toml;
  };
}

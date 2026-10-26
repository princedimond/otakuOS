{ ... }:
{
  flake.modules.homeManager.niri = {
    xdg.configFile."noctalia/config.toml".source = ./noctalia-config.toml;
    home.file."Pictures/Wallpapers".source = ../../../../otakuOS-assets/Wallpapers;
  };
}

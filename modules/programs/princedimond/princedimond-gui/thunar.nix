{ ... }:
{
  flake.modules.nixos.princedimond-gui =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        thunar
        ffmpegthumbnailer # needed to preview images and videos
      ];
      programs.thunar = {
        enable = true;
        plugins = with pkgs; [
          thunar-archive-plugin
          thunar-volman
          thunar-vcs-plugin
          thunar-shares-plugin
          thunar-media-tags-plugin
        ];
      };
      services.gvfs.enable = true;
      services.tumbler.enable = true;
      services.udisks2.enable = true;
      programs.xfconf.enable = true;
    };
}

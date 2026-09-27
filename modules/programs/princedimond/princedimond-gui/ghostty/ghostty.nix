{ ... }:
{
  flake.modules.nixos.princedimond-gui =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ghostty
      ];

    };

  flake.modules.homeManager.princedimond-gui = {
    home.file.".config/zsh/ghostty-colors.zsh".source = ./ghostty-colors.zsh;
    programs.ghostty = {
      enable = true;
      settings = {
        window-decoration = "auto";
        shell-integration-features = "no-title";
      };
    };
  };
}

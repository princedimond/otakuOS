{ ... }:
{
  flake.modules.nixos.princedimond-cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        yazi
      ];
    };

  flake.modules.homeManager.princedimond-cli =
    { pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        plugins = with pkgs.yaziPlugins; {
          git.package = git;
        };
      };
    };
}

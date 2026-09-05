{ ... }:
{
  flake.modules.nixos.princedimond-cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
      ];
    };

  flake.modules.homeManager.princedimond-cli =
    { pkgs, ... }:
    {
      programs.git = {
        enable = true;
        lfs.enable = true;
        settings = {
          credential.helper = "!${pkgs.gh}/bin/gh auth git-credential";
          user = {
            name = "cacarl";
            email = "princedimond@gmail.com";
          };
          fetch.prune = true;
        };
      };
    };
}

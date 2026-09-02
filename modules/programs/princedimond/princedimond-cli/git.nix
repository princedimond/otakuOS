{ ... }:
{
  flake.modules.nixos.princedimond-cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
      ];
    };

  flake.modules.homeManager.princedimond-cli = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = "cacarl";
          email = "princedimond@gmail.comm";
        };
        fetch.prune = true;
      };
    };
  };
}

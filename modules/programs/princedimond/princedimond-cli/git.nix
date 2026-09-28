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
    { pkgs, config, ... }:
    {
      age.secrets.git-credentials.file = ../../../../secrets/git-credentials.age;
      home.file.".git-credentials".source =
        config.lib.file.mkOutOfStoreSymlink config.age.secrets.git-credentials.path;
      programs.git = {
        enable = true;
        lfs.enable = true;
        settings = {
          credential.helper = "store";
          user = {
            name = "cacarl";
            email = "princedimond@gmail.com";
          };
          fetch.prune = true;
        };
      };
    };
}

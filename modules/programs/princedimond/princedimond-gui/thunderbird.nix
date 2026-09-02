{ ... }:
{
  flake.modules.nixos.princedimond-gui =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        thunderbird
      ];
    };

  flake.modules.homeManager.princedimond-gui = {
    programs.thunderbird = {
      enable = true;
      profiles.princedimond = {
        isDefault = true;
        extensions = [ ];
        settings = {
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
  };
}

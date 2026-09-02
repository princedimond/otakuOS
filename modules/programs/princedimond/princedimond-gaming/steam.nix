{ inputs, ... }:
{
  flake.modules.nixos.princedimond-gaming =
    { pkgs, ... }:
    {

      nixpkgs.config.allowUnfreePackages = [
        "steam"
        "steam-unwrapped"
      ];

      programs.steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
    };

  flake.modules.homeManager.princedimond-gaming = {
    imports = [
      inputs.steam-config-nix.homeModules.default
    ];
    programs.steam.config = {
      enable = true;
      onSteamRunning = "close";
      defaultCompatTool = "proton_9";
      apps = {
        "550" = {
          name = "Left 4 Dead 2";
          compatTool = "proton_9";
          args = [
            "-vulkan"
          ];
        };
      };
    };
  };
}

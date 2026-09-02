{ inputs, ... }:
{
  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-base
      ssh
      princedimond-cli
      zsh
      catppuccin-cli
      dev
    ];
  };

  flake.modules.homeManager.system-cli = {
    imports = with inputs.self.modules.homeManager; [
      system-base
      catppuccin-cli
      princedimond-cli
      dev
    ];
  };
}

{ inputs, ... }:
{
  flake.modules.nixos.princedimond-gui =
    {
      ...
    }:
    {
      imports = [ inputs.nix-craftapps.nixosModules.default ];
      /*
        nixpkgs.overlays = [ inputs.nix-craftapps.overlays.default ];
        environment.systemPackages = [
          pkgs.craftapps.photocraft
          pkgs.craftapps.vectorcraft
          pkgs.craftapps.lightcraft
          pkgs.craftapps.pdfcraft
          pkgs.craftapps.effectcraft
          pkgs.craftapps.designcraft
          pkgs.craftapps.filmcraft
          pkgs.craftapps.gridcraft
          pkgs.craftapps.soundcraft
          pkgs.craftapps.cadcraft
          pkgs.craftapps.wordcraft
          pkgs.craftapps.deckcraft
        ];
      */

      programs.craftapps = {
        enable = true;
        enableAll = true;
        /*
          apps.photocraft.enable = true;
          apps.vectorcraft.enable = true;
          apps.lightcraft.enable = true;
          apps.pdfcraft.enable = true;
          apps.effectcraft.enable = true;
          apps.designcraft.enable = true;
          apps.filmcraft.enable = true;
          apps.gridcraft.enable = true;
          apps.soundcraft.enable = true;
          apps.cadcraft.enable = true;
          apps.wordcraft.enable = true;
          apps.deckcraft.enable = true;
        */
      };
    };
}

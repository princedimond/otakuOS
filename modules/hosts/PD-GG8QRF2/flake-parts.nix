{ inputs, ... }:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "PD-GG8QRF2";
}

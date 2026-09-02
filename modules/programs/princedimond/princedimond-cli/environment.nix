{ ... }:
{
  flake.modules.nixos.princedimond-cli = {
    environment.sessionVariables = {
      EDITOR = "hx";
    };
  };
}

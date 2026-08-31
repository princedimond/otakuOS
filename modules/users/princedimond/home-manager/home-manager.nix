{ inputs, ... }:
let
  username = "princedimond";
in
{
  flake.modules.homeManager."${username}" =
    { ... }:
    {
      imports = with inputs.self.modules.homeManager; [
      ];
      home.username = "${username}";
    };
}

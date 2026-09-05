{ ... }:
{
  flake-file.inputs = {
    niri = {
      url = "github:niri-wm/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-appmenu.url = "github:yolo-labz/noctalia-appmenu";
  };
}

{ ... }:
{
  flake.modules.homeManager.niri = {
    programs.niri.settings.spawn-at-startup = [
      { argv = [ "noctalia" ]; }
    ];
  };
}

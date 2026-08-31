{ ... }:
{
  flake.modules.homeManager.system-core =
    { config, ... }:
    {
      home.homeDirectory = "/home/${config.home.username}";
      home.stateVersion = "26.05";
    };
}

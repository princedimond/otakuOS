let
  princedimond = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHATlqjnDgLI98b2IORSYp0e5Kr7e72om9cbBBQI+DWo";
  users = [ princedimond ];

  PD-19KDH72 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKsrz3NqIX6acofeR4YI2zf6xTqeIVj1eNZ1AQc/iWm";
  systems = [ PD-19KDH72 ];

  all = users ++ systems;
in
{
  "pdssh-pub.age".publicKeys = all;
  "pdssh-private.age".publicKeys = all;
}

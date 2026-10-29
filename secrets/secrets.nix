let
  princedimond = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHATlqjnDgLI98b2IORSYp0e5Kr7e72om9cbBBQI+DWo";
  users = [ princedimond ];

  PD-19KDH72 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFG0C+9pMxAMJKthrzM/4r+jBAfrds0L5CM2VFtCMP8Z";
  otakuOS-cache = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKkXrsT1UhYzWB4t7lpvZiauDZG8b6xcJx6oYz+8Bj4K";
  PD-GG8QRF2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKK0FXDJdEEXAqnkXOpCtkNkquUolSfoSIV2lZmQNiBp";
  master = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEeKlYvEId5/wJqCP+ueoCSQuwcEG958d5G0IoAd2HJi";
  PD-5CG84633PQ = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA2uqpaW2WpHOmR+QXDzyeCY92h2mhLCwmzBO9m3xU7t";
  PD-ZENBOOK14X = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkWMcfk7S/DN5MSDAZrIWCQ/osa1xO7/+JghMyh1YoH";
  systems = [
    PD-19KDH72
    PD-GG8QRF2
    otakuOS-cache
    master
    PD-5CG84633PQ
    PD-ZENBOOK14X
  ];

  all = users ++ systems;
in
{
  "git-credentials.age".publicKeys = all;
  "pdssh-pub.age".publicKeys = all;
  "pdssh-private.age".publicKeys = all;
  "pdpwd.age".publicKeys = all;
  "iso-master-pub.age".publicKeys = all;
  "iso-master-key.age".publicKeys = [
    princedimond
    PD-GG8QRF2
    PD-5CG84633PQ
    master
  ];
  "attic-env.age".publicKeys = [
    otakuOS-cache
    princedimond
    master
  ];
  "attic-token.age".publicKeys = all;
}

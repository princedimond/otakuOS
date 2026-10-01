#!/usr/bin/env bash

#Check if the script is being run as root
echo -e "\n\e[32m[INSTALL] PREFORMING PRE-RUN CHECKS\e[0m"
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with sudo (root)" 1>&2
  exit 1
fi

#Check if with sudo and not "real root"
if [[ -z "$SUDO_USER" ]]; then
  echo "This script must be run with sudo (not as a direct root login) so it knows which user's SSH/agenix identity to use" 1>&2
  exit 1
fi

#Init Variables
echo -e "\n\e[32m[INSTALL] INITIALIZING VARIABLES\e[0m"
configSource="git@gitlab.com:princedimond/otakuos.git"
configName="otakuOS"
newHostname=""
systemType=""
installDisk=""
installDiskID=""

#Obtain initial deps
echo -e "\n\e[32m[INSTALL] INITIALIZING DEPENDANCIES\e[0m"
sudo -u "$SUDO_USER" mkdir -p /tmp/installer
sudo -u "$SUDO_USER" git clone --recurse-submodules $configSource /tmp/installer/$configName

#Ask user about required configuration
echo -e "\n\e[32m[INSTALL] ASKING FOR REQUIRED INFORMATION\e[0m"
echo "What is the hostname of this machine?"
read newHostname
echo
echo "Available types:"
#Parse the available system types from the config
ls /tmp/installer/$configName/modules/system/types/ | cut -c 4- | sed 's/\.nix$//'
echo "What system type do you want to use?"
read systemType
echo
echo "Available Disks:"
lsblk --nodeps --noheadings --output NAME,SIZE,MODEL
echo "What disk do you want to install onto?"
read installDisk
echo
echo "You chose:"
echo "Hostname - " $newHostname
echo "System Type - " $systemType
echo "Install Disk - " $installDisk
echo "Is this correct? (y/n)"
read confirmation
if [[ $confirmation != "y" ]]; then
  echo "Aborting installation"
  exit 1
fi

#Log start of automated install
echo -e "\n\e[32m[INSTALL] BEGINNING INSTALL PROCESS\e[0m"

#Grab install disk ID
installDiskID="/dev/$(udevadm info --query=symlink --name="/dev/$installDisk" | tr ' ' '\n' | grep '^disk/by-id/' | head -n1)"

#Generate keys for new system
echo -e "\n\e[32m[INSTALL] GENERATING NEW SYSTEM KEYS\e[0m"
mkdir -p /tmp/installer/keys
ssh-keygen -t ed25519 -f /tmp/installer/keys/id_ed25519 -N ""

#Roll SSH keys for new system into secrets.nix in config
echo -e "\n\e[32m[INSTALL] UPDATING SECRETS.NIX\e[0m"
export newKey=$(echo "  "$newHostname = \"$(cat /tmp/installer/keys/id_ed25519.pub | sed 's/ [^ ]*$//')\"";")
sed -i "s|^[[:space:]][[:space:]]systems =|$newKey\n&|" /tmp/installer/$configName/secrets/secrets.nix
sed -i "s/\(systems = \[[^]]*\) ];/\1 $newHostname ];/" /tmp/installer/$configName/secrets/secrets.nix

#Re-key all secrets
echo -e "\e[32m[INSTALL] RE-KEYING ALL SECRETS\e[0m"
pushd /tmp/installer/$configName/secrets/
agenix --rekey --identity /etc/ssh/ssh_host_ed25519_key
popd

#Generate per-host config for new system
echo -e "\n\e[32m[INSTALL] GENERATING PER-HOST CONFIG\e[0m"
mkdir -p /tmp/installer/$configName/modules/hosts/$newHostname
#Generate flake-parts.nix for new system
cat << EOF > /tmp/installer/$configName/modules/hosts/$newHostname/flake-parts.nix
{ inputs, ... }:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "$newHostname";
}
EOF
#Generate filesystem.nix for new system
cat << EOF > /tmp/installer/$configName/modules/hosts/$newHostname/filesystem.nix
{ inputs, ... }:
{
  flake.modules.nixos.$newHostname =
    { pkgs, config, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        disko
      ];

      disko.device = "$installDiskID";
    };
}
EOF
#Generate configuration.nix for new system
cat << EOF > /tmp/installer/$configName/modules/hosts/$newHostname/configuration.nix
{ inputs, ... }:
{
  flake.modules.nixos.$newHostname = {
    networking.hostName = "$newHostname";

    imports = with inputs.self.modules.nixos; [
      $systemType
    ];

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      $systemType
    ];
  };
}
EOF
#Generate hardware.nix for new system
cat << EOF > /tmp/installer/$configName/modules/hosts/$newHostname/hardware.nix
{ ... }:
{
  flake.modules.nixos.$newHostname = {
$(sudo nixos-generate-config --no-filesystems --show-hardware-config \
  | grep "^[[:space:]]*boot\." \
  | sed 's/^[[:space:]]\{2\}//' \
  | sed 's/^/    /')
  };
}
EOF


#Partition new system
echo -e "\n\e[32m[INSTALL] PARTITIONING DISK WITH DISKO\e[0m"
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake "path:/tmp/installer/$configName#$newHostname"

#Install config onto new system
echo -e "\n\e[32m[INSTALL] INSTALLING NEW SYSTEM\e[0m"
nixos-install --root /mnt --flake "path:/tmp/installer/$configName#$newHostname" --no-root-password

#Move config onto new system
echo -e "\n\e[32m[INSTALL] MOVING CONFIG ONTO NEW SYSTEM\e[0m"
cp -r "/tmp/installer/$configName" "/mnt/$configName"

#Move SSH keys onto new system
echo -e "\n\e[32m[INSTALL] MOVING SSH KEYS ONTO NEW SYSTEM\e[0m"
mkdir -p /mnt/etc/ssh
cp /tmp/installer/keys/id_ed25519 /mnt/etc/ssh/ssh_host_ed25519_key
cp /tmp/installer/keys/id_ed25519.pub /mnt/etc/ssh/ssh_host_ed25519_key.pub
chmod 0600 /mnt/etc/ssh/ssh_host_ed25519_key
chmod 0644 /mnt/etc/ssh/ssh_host_ed25519_key.pub

#Finalize anything else

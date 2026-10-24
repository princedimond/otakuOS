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
configBranch="main"
configName="otakuOS"
newHostname=""
systemType=""
installDisk=""
installDiskID=""
shouldEncrypt=false

#Init functions
initializeDependencies() {
  echo -e "\n\e[32m[INSTALL] INITIALIZING DEPENDANCIES\e[0m"
  rm -rf /tmp/installer
  sudo -u "$SUDO_USER" mkdir -p /tmp/installer
  sudo -u "$SUDO_USER" git clone -b $configBranch --recurse-submodules $configSource /tmp/installer/$configName
}

listSystemTypes() {
  ls "/tmp/installer/$configName/modules/system/types/" | cut -c 4- | sed 's/\.nix$//'
}

askForConfig() {
  echo -e "\n\e[32m[INSTALL] ASKING FOR REQUIRED INFORMATION\e[0m"
  echo "What is the hostname of this machine?"
  read newHostname
  echo
  echo "Available types:"
  #Parse the available system types from the config
  listSystemTypes
  echo "What system type do you want to use? (will be ignored if host config already exists)"
  read systemType
  echo
  echo "Available Disks:"
  lsblk --nodeps --noheadings --output NAME,SIZE,MODEL
  echo "What disk do you want to install onto?"
  read installDisk
  echo
  echo "Do you want to encrypt the disk? (y/n)"
  read encryptChoice
  if [[ $encryptChoice == "y" ]]; then
    shouldEncrypt=true
  else
    shouldEncrypt=false
  fi
}

confirmConfig() {
  #Check if disk or system type actually exists
  if [[ ! -b "/dev/$installDisk" ]]; then
    echo -e "\n\e[31m[INSTALL] ERROR: DISK $installDisk DOES NOT EXIST\e[0m"
    getConfigVars
  elif ! listSystemTypes | grep -qxF "$systemType"; then
    echo -e "\n\e[31m[INSTALL] ERROR: SYSTEM TYPE $systemType DOES NOT EXIST\e[0m"
    getConfigVars
  else
  #Confirm the configuration with the user
    echo -e "\n\e[32m[INSTALL] CONFIRMING CONFIGURATION\e[0m"
    echo "You chose:"
    echo "Hostname - " $newHostname
    echo "System Type - " $systemType
    echo "Install Disk - " $installDisk
    echo "Encrypted - " $shouldEncrypt
    echo "Is this correct? (y/n)"
    read confirmation
    if [[ $confirmation != "y" ]]; then
      getConfigVars
    fi
  fi
}

getConfigVars() {
  askForConfig
  confirmConfig
}

prepAutoInstall() {
  #Log start of automated install
  echo -e "\n\e[32m[INSTALL] BEGINNING INSTALL PROCESS\e[0m"

  #Grab install disk ID
  installDiskID="/dev/$(udevadm info --query=symlink --name="/dev/$installDisk" | tr ' ' '\n' | grep '^disk/by-id/' | head -n1)"
}

generateSSHKeys() {
  echo -e "\n\e[32m[INSTALL] GENERATING SSH KEYS\e[0m"
  sudo -u "$SUDO_USER" mkdir -p /tmp/installer/keys
  sudo -u "$SUDO_USER" ssh-keygen -t ed25519 -f /tmp/installer/keys/id_ed25519 -N ""
}

rekeyAllSecrets() {
  #Roll SSH keys for new system into secrets.nix in config
  echo -e "\n\e[32m[INSTALL] UPDATING SECRETS.NIX\e[0m"
  secretsFile="/tmp/installer/$configName/secrets/secrets.nix"
  pubkey=$(sed 's/ [^ ]*$//' /tmp/installer/keys/id_ed25519.pub)

  #Set or add the key line
  if grep -q "^[[:space:]]*$newHostname = " "$secretsFile"; then
    sed -i "s|^\([[:space:]]*$newHostname = \).*|\1\"$pubkey\";|" "$secretsFile"
  else
    newKey="  $newHostname = \"$pubkey\";"
    sed -i "s|^[[:space:]][[:space:]]systems =|$newKey\n&|" "$secretsFile"
  fi

  #Ensure it's in the systems list
  if ! sed -n '/^[[:space:]]*systems = \[/,/^[[:space:]]*\];/p' "$secretsFile" \
       | grep -qx "[[:space:]]*$newHostname"; then
    sed -i "/^[[:space:]]*systems = \[/,/^[[:space:]]*\];/{
      /^[[:space:]]*\];/i\\    $newHostname
    }" "$secretsFile"
  fi

  #Re-key all secrets
  echo -e "\e[32m[INSTALL] RE-KEYING ALL SECRETS\e[0m"
  pushd /tmp/installer/$configName/secrets/
  agenix --rekey --identity /etc/ssh/ssh_host_ed25519_key
  popd
}

generateFlakeParts() {
cat << EOF > /tmp/installer/$configName/modules/hosts/$newHostname/flake-parts.nix
{ inputs, ... }:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "$newHostname";
}
EOF
}

generateFilesystemConfigEncrypted() {
cat << EOF > /tmp/installer/$configName/modules/hosts/$newHostname/filesystems.nix
{ inputs, ... }:
{
  flake.modules.nixos.$newHostname =
    { pkgs, config, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        disko-encrypted
      ];

      disko.device = "$installDiskID";
    };
}
EOF
}

generateFilesystemConfigUnencrypted() {
cat << EOF > /tmp/installer/$configName/modules/hosts/$newHostname/filesystems.nix
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
}

generateFilesystemConfig() {
  if [[ $shouldEncrypt == true ]]; then
    generateFilesystemConfigEncrypted
  else
    generateFilesystemConfigUnencrypted
  fi
}

generateMainConfig() {
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
}

generateHardwareConfig() {
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
}

generateNewHostConfig() {
  #Generate per-host config for system
  echo -e "\n\e[32m[INSTALL] GENERATING PER-HOST CONFIG\e[0m"

  #Check if host already exists or not
  if [[ -d /tmp/installer/$configName/modules/hosts/$newHostname ]]; then
    #Host already exists, only generate hardware and filesystem configs
    generateHardwareConfig
    generateFilesystemConfig
  else
    #Host does not exist, generate all configs
    mkdir -p /tmp/installer/$configName/modules/hosts/$newHostname
    generateFlakeParts
    generateHardwareConfig
    generateFilesystemConfig
    generateMainConfig
  fi
}

partitionDisk() {
  echo -e "\n\e[32m[INSTALL] PARTITIONING DISK WITH DISKO\e[0m"
  nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake "path:/tmp/installer/$configName#$newHostname"
}

installConfig() {
  echo -e "\n\e[32m[INSTALL] INSTALLING CONFIG ONTO NEW SYSTEM\e[0m"
  nixos-install --root /mnt --flake "path:/tmp/installer/$configName#$newHostname" --no-root-password
}

loadFilesOnSystem() {
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
}

fixPermissionsOnConfig() {
  #Fix permissions on config
  echo -e "\n\e[32m[INSTALL] FIXING PERMISSIONS ON CONFIG\e[0m"
  chown -R root:wheel /mnt/$configName
  find /mnt/$configName -type d -exec chmod 775 {} \;
  find /mnt/$configName -type f -exec chmod 664 {} \;
}

#Run through functions
initializeDependencies
getConfigVars
prepAutoInstall
generateSSHKeys
rekeyAllSecrets
generateNewHostConfig
partitionDisk
installConfig
loadFilesOnSystem
fixPermissionsOnConfig

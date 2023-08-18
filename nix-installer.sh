#1/usr/bin/env bash

if (( $EUID != 0 )); then
    echo "This script must be ran as root"
    exit 1
fi

if [[ ! -f /nix/nix-installer ]]
then
    echo "Nix is already installed, to reinstall type \"sudo /nix/nix-installer uninstall\" then run this"
    exit 1

if [[ ! -d /nix ]]
then
    echo "The nix directory already exists, uninstall nix to continue"
    exit 1
fi

sleep 3

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

sleep 3

echo "Adding sudo path variables for nix"

SUDOPATHVARIABLE5=$(sudo printenv PATH)

sleep 1

tee /etc/sudoers.d/nix-sudo-env <<EOF
Defaults  secure_path = /nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:$SUDOPATHVARIABLE5
EOF

echo "Finished adding sudo variables for nix"

echo "Adding XDG_DATA_DIR locations"

tee /etc/profile.d/nix-xdg-data-variables.sh <<EOF
export XDG_DATA_DIRS="\$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share:\$XDG_DATA_DIRS"
export KDEDIRS="\$HOME/.nix-profile:/nix/var/nix/profiles/default:\$KDEDIRS"
EOF

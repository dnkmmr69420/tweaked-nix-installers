#!/usr/bin/env bash

if (( $EUID != 0 )); then
    echo "This script must be ran as root"
    exit 1
fi

echo "Uninstalling nix..."
rm -f /etc/sudoers.d/nix-sudo-env
rm -f /etc/profile.d/nix-xdg-data-variables.sh
/nix/nix-installer uninstall
echo "Finnished uninstalling nix"

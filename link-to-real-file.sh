#!/usr/bin/env bash

nix_systemd_file_location='/nix/var/nix/profiles/default'

if (( $EUID != 0 )); then
    echo "This script must be ran as root"
    exit 1
fi

rm -f /etc/systemd/system/nix-daemon.service
rm -f /etc/systemd/system/nix-daemon.socket

cp $nix_systemd_file_location/lib/systemd/system/nix-daemon.service /etc/systemd/system/nix-daemon.service
cp $nix_systemd_file_location/lib/systemd/system/nix-daemon.socket /etc/systemd/system/nix-daemon.socket

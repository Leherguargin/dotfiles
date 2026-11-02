#!/bin/bash

# Load OS info
source /etc/os-release
echo "$ID"

install_dir=./install
case "$ID" in
    fedora)
        echo "Detected Fedora"
        chmod +x "$install_dir/fedora.sh"
        "$install_dir/fedora.sh"
        ;;
    debian)
        echo "Detected Debian"
        "$install_dir/debian.sh"
        ;;
    ubuntu)
        echo "Detected Ubuntu"
        "$install_dir/ubuntu.sh"
        ;;
    *)
        echo "Detected other distro: $ID"
        echo "Unknow or unsupported distro!"
        ;;
esac

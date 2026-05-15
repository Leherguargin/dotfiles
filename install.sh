#!/bin/bash

# Load OS info
source /etc/os-release
echo "$ID"

case "$ID" in
    fedora)
        echo "Detected Fedora"
        chmod +x ./install_fedora.sh
        ./install_fedora.sh
        ;;
    debian)
        echo "Detected Debian"
        ./install_debian.sh
        ;;
    ubuntu)
        echo "Detected Ubuntu"
        ./install_ubuntu.sh
        ;;
    *)
        echo "Detected other distro: $ID"
        echo "Unknow or unsupported distro!"
        ;;
esac

#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)" # global path to script
INSTALL_DIR="$SCRIPT_DIR/install"

if [[ -f /etc/os-release ]]; then
    source /etc/os-release
else
    echo "Error: No file /etc/os-release. Cannot identify operating system."
    exit 1
fi

case "$ID" in
    fedora)
        echo "Detected Fedora"
        SCRIPT_TO_RUN="$INSTALL_DIR/fedora.sh"
        ;;
    debian)
        echo "Detected Debian"
        SCRIPT_TO_RUN="$INSTALL_DIR/debian.sh"
        ;;
    ubuntu)
        echo "Detected Ubuntu"
        SCRIPT_TO_RUN="$INSTALL_DIR/ubuntu.sh"
        ;;
    *)
        echo "Detected other distro: $ID"
        echo "Unknow or unsupported distro!"
        exit 1
        ;;
esac

if [[ -f "$SCRIPT_TO_RUN" ]]; then
    chmod +x "$SCRIPT_TO_RUN"
    "$SCRIPT_TO_RUN"
else
    echo "Error: cannot find scirpt: $SCRIPT_TO_RUN"
    exit 1
fi
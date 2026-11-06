#!/bin/bash

set -euo pipefail

if ! command -v sdk >/dev/null 2>&1; then
    echo "sdk already installed"
    exit 0
fi

if [ "$EUID" -ne 0 ]; then
    echo "run this script with sudo: \`sudo ./global_sdkman.sh\`!"
    exit 1
fi

printf "\033[35m -------------------- global sdkman -------------------- \033[0m\n"

export SDKMAN_DIR="/opt/sdkman"
if command -v apt >/dev/null 2>&1; then
    apt update
    apt install unzip zip tar findutils curl sed bash
elif command -v dnf >/dev/null 2>&1; then
    dnf update
    dnf install unzip zip tar findutils curl sed bash
else
    echo "cannot find any known package manager!"
    exit 1
fi
curl -s "https://get.sdkman.io" | bash
chmod -R 775 "$SDKMAN_DIR"

cat << 'EOF' > /etc/profile.d/sdkman.sh
export SDKMAN_DIR="/opt/sdkman"
umask 002
if [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]]; then
    source "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi
EOF

chmod +x /etc/profile.d/sdkman.sh

groupadd sdkman-group
chown -R root:sdkman-group /opt/sdkman
chmod -R 775 /opt/sdkman
find /opt/sdkman -type d -exec chmod g+s {} +

echo "add users to sdkman-group for access to sdkman by:"
echo "\`sudo usermod -aG sdkman-group <username>\`"

printf "\033[35m Done, SDKMAN installed globally in /opt/sdkman. \033[0m\n"

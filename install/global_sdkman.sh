#!/bin/bash
set -euo pipefail
set -e

if [ "$EUID" -ne 0 ]; then
    echo "run this script with sudo: sudo ./global_sdkman.sh!"
    exit 1
fi

echo -e "\e[35m -------------------- global sdkman -------------------- \e[0m"

export SDKMAN_DIR="/opt/sdkman"
apt install unzip zip tar find curl sed
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

echo "add users to sdkman-group for access to python by:"
echo "sudo usermod -aG sdkman-group <username>"

echo -e "\e[32m Done, SDKMAN installed globally in /opt/sdkman. \e[0m"

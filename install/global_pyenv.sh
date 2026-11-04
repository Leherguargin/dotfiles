#!/bin/bash

set -euo pipefail

if [ "$EUID" -ne 0 ]; then
    echo "run this script with sudo: \`sudo ./global_sdkman.sh\`!"
    exit 1
fi

printf "\033[35m -------------------- global pyenv -------------------- \033[0m\n"

apt update
apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev git

git clone https://github.com/pyenv/pyenv.git /opt/pyenv

tee /etc/profile.d/pyenv.sh << 'EOF'
export PYENV_ROOT="/opt/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
umask 002
eval "$(pyenv init -)"
EOF

chmod +x /etc/profile.d/pyenv.sh
chmod -R 775 /opt/pyenv

groupadd pyenv-group
chown -R root:pyenv-group /opt/pyenv
find /opt/pyenv -type d -exec chmod g+s {} +

echo "add users to pyenv-group for access to python by:"
echo "\`sudo usermod -aG pyenv-group <username>\`"

printf "\033[35m Done, pyenv installed globally in /opt/pyenv. \033[0m\n"

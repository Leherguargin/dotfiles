echo -e "\e[35m -------------------- global pyenv -------------------- \e[0m"
sudo apt update
sudo apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev git

sudo git clone https://github.com/pyenv/pyenv.git /opt/pyenv

sudo tee /etc/profile.d/pyenv.sh << 'EOF'
export PYENV_ROOT="/opt/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF

sudo chmod +x /etc/profile.d/pyenv.sh
sudo chmod -R 775 /opt/pyenv

sudo groupadd pyenv-group
sudo chown -R root:pyenv-group /opt/pyenv
sudo find /opt/pyenv -type d -exec chmod g+s {} +

echo "add users to pyenv-group for access to python by:"
echo "sudo usermod -aG pyenv-group <username>"

echo -e "\e[32m Done, pyenv installed globally in /opt/pyenv. \e[0m"
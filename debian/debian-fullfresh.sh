NC='\033[0m'
GREEN='\033[0;32m'
RED='\033[0;31m'

if sudo -n true 2>/dev/null; then
    echo "${GREEN}Beginning ${NC}\'debian-fullfresh.sh\'"
else
    echo "${RED}Please execute as root!"
    exit
fi

echo "${GREEN}Updating/full-upgrading all APT packages"
sudo apt update | sudo apt -y full-upgrade

echo "Installing \`git\`, \`tmux\`, and \`vim\`"
sudo apt install git tmux nvim

echo "Installing 1Password"
echo "    Adding 1Password repo key"
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo "    Adding 1Password repo"
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
echo "    Add the debsig-verify policy"
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
echo "    Installing 1Password"
sudo apt update && sudo apt install 1password

rm debian-fullfresh.sh
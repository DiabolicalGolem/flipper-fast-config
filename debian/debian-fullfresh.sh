NC='\033[0m'
GREEN='\033[0;32m'
RED='\033[0;31m'

if sudo -n true 2>/dev/null; then
    echo -e "\033[0;32mBeginning \033[0m\'debian-fullfresh.sh\'"
else
    echo -e "\033[0;31mPlease execute as root!\033[0m"
    exit
fi

echo -e "\033[0;32mUpdating/full-upgrading all APT packages\033[0m"
sudo apt update | sudo apt -y full-upgrade

echo -e "\033[0;32mInstalling \`git\`, \`tmux\`, and \`vim\`\033[0m"
sudo apt install git tmux nvim

echo -e "\033[0;32mInstalling 1Password\033[0m"
echo -e "    \033[0;32mAdding 1Password repo key\033[0m"
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo -e "    \033[0;32mAdding 1Password repo\033[0m"
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
echo -e "    \033[0;32mAdd the debsig-verify policy\033[0m"
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
echo "    \033[0;32mInstalling 1Password\033[0m"
sudo apt update && sudo apt install 1password

rm debian-fullfresh.sh
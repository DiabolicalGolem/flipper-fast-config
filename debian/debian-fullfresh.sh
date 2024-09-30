NC='\033[0m'
GREEN='\033[0;32m'
RED='\033[0;31m'

if sudo -n true 2>/dev/null; then
    echo -e "${GREEN}Beginning ${NC}\'debian-fullfresh.sh\'"
else
    echo -e "${RED}Please execute as root!${NC}"
    exit
fi

echo -e "${GREEN}Updating/full-upgrading all APT packages${NC}"
sudo apt update | sudo apt -y full-upgrade

echo -e "${GREEN}Installing \`git\`, \`tmux\`, and \`vim\`${NC}"
sudo apt install git tmux nvim

echo -e "${GREEN}Installing 1Password${NC}"
echo -e "    ${GREEN}Adding 1Password repo key${NC}"
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo -e "    ${GREEN}Adding 1Password repo${NC}"
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
echo -e "    ${GREEN}Add the debsig-verify policy${NC}"
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
echo "    ${GREEN}Installing 1Password${NC}"
sudo apt update && sudo apt install 1password

rm debian-fullfresh.sh
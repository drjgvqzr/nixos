#sudo mkdir /mnt
#sudo mount /dev/sdb1 /mnt
#sh /mnt/nixos/imp.sh
nmcli device wifi list
read -p "Enter WiFi SSID: " ssid
read -s -p "Enter WiFi password: " password
nmcli device wifi connect "$ssid" password "$password"
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
mkdir -p /home/soma/dx/
mkdir -p /home/soma/.config
mv /mnt/nixos /home/soma/dx/
sudo rm /etc/nixos/configuration.nix
sudo ln -s ~/dx/nixos/configuration.nix /etc/nixos/configuration.nix
ln -s /home/soma/dx/nixos/misc/.logseq /home/soma/.logseq
sudo sed -r 's/"luks[^"]+"/"luks"/g' -i /etc/nixos/hardware-configuration.nix
sudo nixos-rebuild switch --upgrade
iwctl --passphrase=$password station wlan0 connect $ssid
rm -rf ~/Sync 2> /dev/null
rm -rf ~/.zsh_history 2> /dev/null
rm -rf ~/.zcompdump* 2> /dev/null
rm -rf ~/.lesshst 2> /dev/null
rm -rf ~/.bash_history 2> /dev/null
sed -i 's/cmd => "\/nix\/store\/[^ ]*\/mpv/cmd => "\/etc\/profiles\/per-user\/soma\/bin\/mpv/g' /home/soma/.config/pipe-viewer/pipe-viewer.conf
sed -i 's/--really-quiet --force-media-title=\*TITLE\* --no-ytdl \*VIDEO\*/\*URL\*/' /home/soma/.config/pipe-viewer/pipe-viewer.conf
setfont -d &> /dev/null
ya pkg add yazi-rs/plugins:smart-enter &> /dev/null
ya pkg add yazi-rs/plugins:full-border &> /dev/null
ya pkg add yazi-rs/plugins:no-status &> /dev/null
pactl set-source-volume @DEFAULT_SOURCE@ 50%
exit

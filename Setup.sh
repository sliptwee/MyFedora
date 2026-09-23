#!/bin/bash

clear
echo "// Requesting Admin Password"
echo

sudo -v

clear
echo "// Make Sure To Turn On Your VPN Before Proceeding! (Press Enter To Continue)"
echo

read

echo
echo "// Making Backup (~/Backup)"
echo

mkdir ~/Backup
rsync -av ~/.bashrc ~/Backup
rsync -av ~/.config ~/Backup
rsync -av ~/.fonts ~/Backup
rsync -av ~/.gitconfig ~/Backup
rsync -av ~/.gtkrc-2.0 ~/Backup
rsync -av ~/.local ~/Backup

clear
echo "// Copying Custom Configurations"
echo

# sudo rsync -a ~/Downloads/MyFedora-main/Files/ ~/
# sudo cp ~/Downloads/MyFedora-main/Files/Pictures/Avatar.png /var/lib/AccountsService/icons/
# sudo mv /var/lib/AccountsService/icons/Avatar.png /var/lib/AccountsService/icons/$USER

sudo rsync -a "$(realpath "$0")"/Files/ ~/
sudo cp "$(realpath "$0")"/Files/Pictures/Avatar.png /var/lib/AccountsService/icons/$USER
sudo mv /var/lib/AccountsService/icons/Avatar.png /var/lib/AccountsService/icons/$USER

dirname "$(realpath "$0")"

clear
echo "// Updating The System"
echo

sudo dnf update -y

clear
echo "// Debloating And Configuring Fedora"
echo

sudo dnf install gnome-shell-extension-appindicator adw-gtk3-theme -y
sudo dnf remove gnome-contacts mediawriter gnome-maps gnome-font-viewer malcontent-control gnome-tour yelp -y

gsettings set org.gnome.shell enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com']"
gsettings set org.gnome.desktop.interface monospace-font-name 'Maple Mono 11'
gsettings set org.gnome.desktop.interface font-name 'Maple Mono 11'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita-Gray-Custom'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'

flatpak override --user --filesystem=xdg-config/gtk-3.0:ro
flatpak override --user --filesystem=xdg-config/gtk-4.0:ro

clear
echo "// Installing DNF Packages"
echo

sudo dnf install wget btop fastfetch gnome-shell-extension-appindicator gnome-tweaks niri speedtest -y
sudo dnf group install virtualization -y

clear
echo "// Installing RPM Packages"
echo

cd ~
wget -O code.rpm "https://code.visualstudio.com/sha/download?build=stable&os=linux-rpm-x64"

clear

sudo dnf install ./code.rpm -y
sudo rm -rf ./code.rpm

clear
echo "// Installing Flatpaks"
echo

flatpak install -y flathub com.obsproject.Studio dev.vencord.Vesktop com.spotify.Client com.dec05eba.gpu_screen_recorder md.obsidian.Obsidian org.telegram.desktop com.rafaelmardojai.Blanket com.mattjakeman.ExtensionManager org.localsend.localsend_app com.valvesoftware.Steam no.mifi.losslesscut io.github.ungoogled_software.ungoogled_chromium com.github.tchx84.Flatseal org.vinegarhq.Sober com.infinipaint.infinipaint app.zen_browser.zen ca.desrt.dconf-editor io.github.josephmawa.Bella org.prismlauncher.PrismLauncher org.kde.krita

clear
echo "// Creating Default Config Files"
echo

code &
sleep 5
pkill -9 code

flatpak run app.zen_browser.zen &
sleep 5
pkill -9 zen

flatpak run com.obsproject.Studio &
sleep 5
pkill -9 obs

flatpak run org.vinegarhq.Sober &
sleep 5
pkill -9 sober

flatpak run org.prismlauncher.PrismLauncher &
sleep 5
pkill -9 prismrun

flatpak override --user --filesystem=xdg-run/app/com.discordapp.Discord:create --filesystem=xdg-run/discord-ipc-0 org.vinegarhq.Sober

echo
echo "// Installing VSCode Extensions"
echo

code --install-extension ms-python.python

clear
echo "// Done! The System Will Reboot in 5 Seconds..."
echo

sleep 5
reboot

#!/bin/bash

clear
echo "// Requesting Admin Password"
echo

sudo -v

clear
echo "// Make Sure You Have Unrestricted Internet Access Before Proceeding! (Press Enter To Continue)"
echo

read

clear
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

sudo rsync -a $(dirname "$(readlink -f "$0")")/Files/ ~/

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
gsettings set org.gnome.desktop.interface accent-color 'slate'

flatpak override --user --filesystem=xdg-config/gtk-3.0:ro
flatpak override --user --filesystem=xdg-config/gtk-4.0:ro

clear
echo "// Installing DNF Packages"
echo

sudo dnf install wget git btop fastfetch gnome-shell-extension-appindicator gnome-tweaks niri noctalia kitty -y

clear
echo "// Done! The System Will Reboot in 5 Seconds..."
echo

sleep 5
reboot
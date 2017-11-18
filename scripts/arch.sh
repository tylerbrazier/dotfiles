#!/bin/bash
set -e

# Custom configuration script to be run after a fresh Arch linux installation
# (follow the steps in the installation guide first:
# https://wiki.archlinux.org/index.php/Installation_guide)

timezone=America/Chicago
packages=(
# essentials
vim
git
tmux
htop
openssh
bash-completion

# for wireless networking (wifi-menu)
# https://wiki.archlinux.org/index.php/netctl
dialog
wpa_supplicant

# gui stuff
i3
dmenu
rxvt-unicode
ttf-dejavu
xorg-server
xorg-xinit
xorg-xset
xorg-xrandr  # for screen configuration
xorg-xbacklight
numlockx
alsa-utils
gvim  # includes clipboard support
neovim
xsel  # clipboard support for neovim
firefox

# retro game stuff
retroarch
retroarch-assets-xmb
retroarch-autoconfig-udev
)
services=(
systemd-timesyncd.service  # ntp (can be enabled but not started in chroot)
#dhcpcd.service  # for wired network
)

pacman -Sy --needed sudo git ${packages[@]}

systemctl enable ${services[@]}

ln -sf /usr/share/zoneinfo/$timezone /etc/localtime

# uncomment localization
sed -i~ -e 's/^#\(en_US\.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen

echo 'LANG=en_US.UTF-8' > /etc/locale.conf

read -p 'hostname: ' hostname
echo $hostname > /etc/hostname
hostname $hostname  # keygen.sh won't read /etc/hostname until reboot

echo 'Root password'
passwd root

# allow member of wheel group to run sudo without a password
sed -i~ -e 's/^# *\(%wheel ALL=(ALL) NOPASSWD: ALL\)/\1/' /etc/sudoers

read -p 'new user: ' user
useradd -m -g wheel -s /bin/bash $user

echo "Password for $user"
passwd $user

sudo -H -u $user bash -c "
$(dirname "$0")/keygen.sh
git clone git@github.com:tylerbrazier/dotfiles ~/dotfiles
~/dotfiles/scripts/dotfiles.sh -f -p -g
"

echo "finished $0"

#!/bin/bash
set -e

# Custom configuration script to be run after a fresh Arch linux installation.
# Follow the steps in the installation guide first:
# https://wiki.archlinux.org/index.php/Installation_guide
#
# I used to maintain scripts for automating the installation process but:
# - some steps are machine-specific (partitioning MBR vs GPT, raspberry pi)
# - installing manually gives me a chance to re-familiarize myself with tools I
#   don't use as often (e.g. fdisk)
# - arch is a rolling release and the installation process changes more often
#   than I reinstall my OS; keeping the script up to date requires going back to
#   the guide anyway
#
# Some of the steps here are already covered by the installation guide but I've
# decided to include them so the script can be run on "preinstalled" systems
# such as raspberry pi or a VPS.

timezone=America/Chicago
packages=(
# essentials
vim
git
tmux
htop
openssh
bash-completion

# laptop stuff
dialog  # for wifi-menu
wpa_supplicant
acpi  # for battery status

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
polkit  # allows poweroff,reboot,etc. commands without sudo
gvim  # includes clipboard support
neovim
xsel  # clipboard support for neovim
firefox

# retro game stuff
retroarch
retroarch-assets-xmb
retroarch-autoconfig-udev
libretro-nestopia  # nes core
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

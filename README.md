# dotfiles
Personal configuration files and scripts

## Arch linux
What to run after a fresh [installation][1] (as root in `~`):

    systemctl start dhcpcd  # start wired internet
    pacman -Sy git sudo
    git clone https://github.com/tylerbrazier/dotfiles

    cd dotfiles/scripts
    ./packages.arch.sh  # install packages
    ./services.sh       # enable services
    ./superuseradd.sh   # add a user who can sudo

    su tyler  # or whatever you named your superuser
    ./keygen.sh  # generate ssh key pair
    git clone git@github.com:tylerbrazier/dotfiles ~/dotfiles
    ~/dotfiles/scripts/mklinks.sh -f  # makes symlinks in home to dotfiles
    ~/dotfiles/scripts/gnome.sh  # if gnome was installed

## Ubuntu server
What to run after creating a droplet on [Digital Ocean][2] (as root in `~`):

    git clone https://github.com/tylerbrazier/dotfiles
    cd dotfiles/scripts
    ./superuseradd.sh   # add a user who can sudo

    su tyler  # or whatever you named your superuser
    ./keygen.sh  # generate ssh key pair
    git clone git@github.com:tylerbrazier/dotfiles ~/dotfiles
    ~/dotfiles/scripts/mklinks.sh -f  # makes symlinks in home to dotfiles

    exit  # become root again
    cp ~/.ssh/authorized_keys /home/tyler/.ssh/authorized_keys
    chown tyler:wheel /home/tyler/.ssh/authorized_keys

    # optionally set root's password
    passwd

To enable 2 factor authentication for password logins

    apt update
    apt install libpam-google-authenticator
    sudo -H -u tyler google-authenticator
    # answer the questions

    # add the following at the end of /etc/pam.d/sshd:
    auth required pam_google_authenticator.so

    # set the following in /etc/ssh/sshd_config:
    ChallengeResponseAuthentication yes

    systemctl restart sshd.service

Web server

    apt install nginx
    rm /etc/nginx/sites-enabled/default  # remove link to default welcome page

    # in /etc/nginx/nginx.conf, add the following in the existing http directive
    http {
      server {
        location / {
          root /home/tyler/web;  # or wherever
          autoindex on;  # for directory index listing
        }
      }
    }

    # reload conf
    nginx -s reload

## [Termux][3]
Pinch to zoom, `VolumeDown` for `Ctrl`, long press for copy/paste/help menu.

    VolumeUp + e for Escape
    VolumeUp + t for Tab
    VolumeUp + q to toggle extra keyboard buttons

Swipe left on the extra buttons row for text input, to be used for pasting and
swipe typing. Unless I need the text input, I usually hide the extra buttons
because they take up too much space, and use an index finger to hit the volume
keys.

    # for sdcard access (https://wiki.termux.com/wiki/Termux-setup-storage)
    termux-setup-storage

    pkg install git
    git clone https://github.com/tylerbrazier/dotfiles

    cd dotfiles/scripts
    ./packages.termux.sh
    ./mklinks.sh -f
    ./keygen.sh

    # for push access
    git remote set-url origin git@github.com:tylerbrazier/dotfiles

    # to disable the annoying vibrate bell (https://termux.com/configuration.html)
    mkdir -p ~/.termux
    echo bell-character=ignore > ~/.termux/termux.properties

[1]: https://wiki.archlinux.org/index.php/installation_guide
[2]: https://www.digitalocean.com/
[3]: https://play.google.com/store/apps/details?id=com.termux&hl=en

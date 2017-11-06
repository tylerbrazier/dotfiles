#!/usr/bin/env bash

# Generate a ssh keypair for this host and offer to upload the
# public key to github, digital ocean, and other servers.

# make sure ssh is installed
command -v ssh >/dev/null 2>&1 || { echo 'install openssh first' >&1; exit 1; }

key=~/.ssh/id_rsa
comment="$(whoami)@$(hostname) $(date -I)"

ssh-keygen -t rsa -f "$key" -C "$comment"

ask() {
  read -p "$1 [Y/n] " result
  result="${result:0:1}" # just the first character
  result="${result,,}"   # to lower case
  [ -z "$result" -o "$result" == "y" ]
}

if ask "Upload public key to Github?"; then
  read -p 'username: ' user
  read -p 'password: ' -s pass && echo
  read -p '2fa otp: ' otp
  echo
  url="https://api.github.com/user/keys"
  data="{\"title\":\"$comment\",\"key\":\"$(cat ${key}.pub)\"}"
  curl -i -u "${user}:${pass}" -H "X-GitHub-OTP: $otp" -d "$data" "$url"
fi

if ask "Upload public key to Digital Ocean?"; then
  echo 'Create a token at https://cloud.digitalocean.com/settings/api/tokens'
  read -p 'API token: ' token
  data="{\"name\":\"$comment\",\"public_key\":\"$(cat ${key}.pub)\"}"
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $token" \
    -d "$data" \
    "https://api.digitalocean.com/v2/account/keys"
  echo
fi

while ask "Upload public key to another server?"; do
  read -p '[user@]host: ' host
  ssh-copy-id -i "$key" "$host"
done

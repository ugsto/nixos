#!/usr/bin/env

set -e

TMPDIR="$(mktemp -d)"

cd "$TMPDIR"

curl -sL 'https://github.com/ugsto/nixos/archive/refs/heads/main.zip' -o ./nixos.zip
unzip nixos.zip

cd nixos-main

DISK=""
while [ -z "$DISK" ]; do
  echo -n 'In which disk do you wish to install NixOS? (e.g. /dev/sda): '
  read -r DISK

  if [ ! -b "$DISK" ]; then
    echo 'Invalid disk'
    DISK=""
  fi
done

ENCRYPTION_PASSWORD=""
while [ -z "$ENCRYPTION_PASSWORD" ]; do
  echo -n 'Enter your encryption password: '
  read -rs ENCRYPTION_PASSWORD

  echo -en '\nRetype your encryption password: '
  read -rs ENCRYPTION_PASSWORD_RETYPE

  if [ "$ENCRYPTION_PASSWORD" != "$ENCRYPTION_PASSWORD_RETYPE" ]; then
    echo 'Passwords do not match'
    ENCRYPTION_PASSWORD=""
  fi
done
echo -n "$ENCRYPTION_PASSWORD" > /tmp/secret.key

FLAKE_PROFILES="$(grep '^\s\+nixosConfigurations\.' flake.nix | cut -d'.' -f2 | cut -d' ' -f1)"
FLAKE_PROFILE=""

echo "Available profiles:"
i=1
profiles=""
for profile in $FLAKE_PROFILES; do
  echo "$i) $profile"
  profiles="$profiles $profile"
  i=$((i + 1))
done

profiles_array=$(echo "$profiles" | tr ' ' '\n')

while [ -z "$FLAKE_PROFILE" ]; do
  printf 'Choose a profile by number: '
  read -r profile_number

  i=1
  for profile in $profiles_array; do
    if [ "$i" -eq "$profile_number" ]; then
      FLAKE_PROFILE=$profile
      break
    fi
    i=$((i + 1))
  done

  if [ -z "$FLAKE_PROFILE" ]; then
    echo 'Invalid selection'
  fi
done

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --arg disk "\"$DISK\"" --flake .#bootstrap

(
	cd /mnt
	sudo nixos-generate-config --root /mnt
)

cp /mnt/etc/nixos/hardware-configuration.nix .
sudo rm /mnt/etc/nixos/*

sudo nixos-install --flake ".#$FLAKE_PROFILE"

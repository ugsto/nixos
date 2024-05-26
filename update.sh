#!/usr/bin/env

set -e

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

sudo nixos-generate-config
cp /etc/nixos/hardware-configuration.nix .
sudo rm /etc/nixos/*

sudo nixos-rebuild switch --flake ".#$FLAKE_PROFILE"

{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/boot.nix
      ./modules/i18n.nix
      ./modules/inputs.nix
      ./modules/networking.nix
      ./modules/sound.nix
      ./modules/users.nix
      ./modules/xserver.nix
    ];

  system.stateVersion = "23.11";
}

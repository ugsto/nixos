{ pkgs, inputs, nix-colors, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  home.username = "kurisu";
  home.homeDirectory = "/home/kurisu";

  home.packages = with pkgs; [
    neovim
    gitMinimal
    htop
    fortune
  ];

  programs.firefox.enable = true;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}

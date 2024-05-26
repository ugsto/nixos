{ ... }: {
  programs.home-manager.enable = true;
  imports = [
    ./hyprland.nix
  ];

  home.username = "kurisu";
  home.homeDirectory = "/home/kurisu";
  home.stateVersion = "23.11";
}

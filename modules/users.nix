{ ... }:

{
  users.users.kurisu = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}

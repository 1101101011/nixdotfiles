{ ... }:
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./lemp.nix
    ./locale.nix
    ./networking.nix
    ./steam.nix
    ./system.nix
    ./user.nix
    ./vm.nix
    ./services
    ./wayland.nix
  ];
}

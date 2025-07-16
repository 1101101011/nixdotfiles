{ ... }:
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./lampp.nix
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

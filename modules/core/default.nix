{ ... }:
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./home-manager.nix
    ./lemp
    ./locale.nix
    ./networking.nix
    ./printers
    ./steam.nix
    ./system.nix
    ./user.nix
    ./vm.nix
    ./services
    ./wayland.nix
    ./kubernetes
  ];
}

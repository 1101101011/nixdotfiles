{
  host,
  config,
  lib,
  ...
}:
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./home-manager.nix
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

  config = lib.mkMerge [
    (lib.mkIf (host == "Kuroha") {
      steam.enable = true;
      vm.enable = true;
      wayland.enable = true;
    })

    (lib.mkIf (host == "Kurohikari") {
      steam.enable = true;
      vm.enable = false;
      wayland.enable = true;
    })
  ];
}

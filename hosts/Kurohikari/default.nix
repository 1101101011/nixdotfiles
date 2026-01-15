{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./../../modules/core
    ./hardware-configuration.nix
  ];

  config = {
    environment.systemPackages = with pkgs; [
      brightnessctl
      tlp
      acpi
    ];

    #core stuff
    steam.enable = true;
    vm.enable = false;
    wayland.enable = true;
    lemp.enable = true;
    #home-manager stuff
  };
}

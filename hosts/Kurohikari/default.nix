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
    vm.enable = true;
    wayland.enable = true;
    # lemp.enable = false;
    #home-manager stuff
  };
}

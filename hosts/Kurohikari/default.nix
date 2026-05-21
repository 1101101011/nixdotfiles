{ pkgs, ... }:
{
  imports = [
    ./../../modules/core
    ./hardware-configuration.nix
  ];

  config = {
    environment.systemPackages = with pkgs; [
      brightnessctl
      acpi
    ];

    networking.interfaces.wlp3s0 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.1.69";
          prefixLength = 24;
        }
      ];
    };
    #core stuff
    steam.enable = true;
    vm.enable = true;
    wayland.enable = true;
    kube.enable = true;
  };
}

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./../../modules/core
    ./hardware-configuration.nix
  ];

  config = {
    environment.systemPackages = with pkgs; [
      tlp
    ];

    steam.enable = true;
    vm.enable = true;
    wayland.enable = true;
    lemp.enable = true;
  };
}

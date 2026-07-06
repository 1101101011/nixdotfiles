{ ... }:
{
  imports = [
    ./../../modules/core
    ./hardware-configuration.nix
  ];

  config = {
    steam.enable = true;
    vm.enable = true;
    wayland.enable = true;
    printers.enable = true;
    # lemp.enable = true;
  };
}

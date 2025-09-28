{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./tlp.nix
    ./udev.nix 
    ./audio-drivers.nix
  ];
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  services = {
    displayManager.ly = {
      enable = true;
    };
    openssh.enable = true;
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    tlp.enable = true;
    upower.enable = true;
  };
}

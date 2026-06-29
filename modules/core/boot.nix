{ pkgs, ... }:
{
  boot.loader = {
    kernelPackages = pkgs.linuxPackages_latest;
    # systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      #efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
      enable = true;
      enableCryptodisk = false;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
    };
  };
}

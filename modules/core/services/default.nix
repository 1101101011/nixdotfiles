{
  host,
  config,
  lib,
  ...
}:
{
  imports = [
    ./tlp.nix
    ./udev.nix
    ./audio-drivers.nix
  ];

  config = lib.mkMerge [
    (lib.mkIf (host != "Kurohikari") {
      tlp.enable = false;
      udev.enable = false;
    })

    (lib.mkIf (host == "Kurohikari") {
      tlp.enable = true;
      udev.enable = true;
    })
    {
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
        upower.enable = true;
      };
    }
  ];
}

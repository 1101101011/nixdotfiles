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
    ./github-runners.nix
  ];

  config = lib.mkMerge [
    (lib.mkIf (host != "Kurohikari") {
      tlp.enable = false;
      udev.enable = false;
      gh-runners.enable = false;
    })

    (lib.mkIf (host == "Kurohikari") {
      tlp.enable = true;
      udev.enable = true;
      gh-runners.enable = true;
    })
    {
      # Enable CUPS to print documents.
      # services.printing.enable = true;

      # Enable touchpad support (enabled default in most desktopManager).
      # services.libinput.enable = true;
      services = {
        displayManager.ly = {
          enable = true;
          settings = {
            load = true;
            save = true;
          };
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

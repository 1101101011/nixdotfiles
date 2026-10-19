{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    wayland.enable = lib.mkEnableOption "Enable Wayland with Hyprland";
  };

  config = lib.mkIf config.wayland.enable {
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      };
    };

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      nvidia.modesetting.enable = true;
    };

    xdg.portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];

      config = {
        common = {
          default = [ "gtk" ];
        };

        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
          "org.freedesktop.impl.portal.GlobalShortcuts" = [ "hyprland" ];
        };
      };
    };
  };
}

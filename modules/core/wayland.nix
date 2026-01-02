{ config, lib, pkgs, inputs, ... }:
{
  options = {
    wayland.enable = lib.mkEnableOption "Enable Wayland with Hyprland";
  };

  config = lib.mkIf config.wayland.enable {
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
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
    xdg = {
      portal = {
        enable = true;
        config.common.default = "*";
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-hyprland
          pkgs.xdg-desktop-portal-wlr
        ];
      };
    };
  };
}

{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  options = {
    myHypr.enable = lib.mkEnableOption "Enable Hyprland and related programs";
  };
  config = lib.mkIf config.myHypr.enable {
    programs = {
      hyprlock.enable = true;
    };
  };
}

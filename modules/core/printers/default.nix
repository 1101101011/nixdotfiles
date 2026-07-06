{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    printers.enable = lib.mkEnableOption "Enable Driver Support for Printers";
  };
  config = lib.mkIf config.printers.enable {
    hardware.sane.enable = true;
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        epson-escpr
        epson-escpr2
        epson-201401w
      ];
    };
  };
}

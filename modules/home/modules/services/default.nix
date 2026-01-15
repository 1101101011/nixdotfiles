{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  options = {
    myServices.enable = lib.mkEnableOption "Enable custom user services";
  };
  imports = [
    ./scripts
  ];
  config = lib.mkIf config.myServices.enable {
  };
}

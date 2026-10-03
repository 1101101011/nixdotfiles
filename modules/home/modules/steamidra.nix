{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.nix-crab.homeModules.default ];
  options = {
    mySteamidra.enable = lib.mkEnableOption "Enable steamidra";
  };
  config = lib.mkIf config.mySteamidra.enable {
    programs.nix-crab = {
      steamidra.enable = true;
      slssteam.manageConfig = false;
    };
  };
}

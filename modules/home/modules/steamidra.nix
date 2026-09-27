{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.nix-crab.homeModules.default ];
  optionns = {
    mySteamidra.enable = lib.mkEnabledOption "Enable steamidra";
  };
  config = lib.mkIf config.mySteamidra.enable {
    programs.nix-crab = {
      steamidra.enable = true;
      # slssteam.manageConfig = true;
    };
  };
}

{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-crab.nixosModules.default
  ];
  options = {
    steam.enable = lib.mkEnableOption "Enable Steam and related programs";
  };
  config = lib.mkIf config.steam.enable {
    programs.nix-crab.slssteam.enable = true;
    programs.nix-crab.cloudredirect.enable = true;
    # programs.nix-crab.millennium.enable = true;  # optional
    # programs.nix-crab.downgrade.enable = true;   # optional
    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;
      };
    };
  };
}

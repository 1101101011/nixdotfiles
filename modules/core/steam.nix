{ config, lib, pkgs, inputs, ... }:
{
  options = {
    steam.enable = lib.mkEnableOption "Enable Steam and related programs"; 
  };
  config = lib.mkIf config.steam.enable {
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

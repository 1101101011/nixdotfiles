{ config, pkgs, lib, inputs, ... }:
{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      nitch
      alias ls='lsd'
      alias tree='lsd --tree'
    '';
    enableCompletion = true;
  };
}

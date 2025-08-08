{
  config,
  lib,
  pkgs,
  inputs,
  username,
  host,
  ...
}:
{
  # home-manager = {
  #   home.username = "${username}";
  #   home.homeDirectory = "/home/${username}";
  #   home.stateVersion = "25.05";
  # };
  imports = [
    ./modules
  ];
}

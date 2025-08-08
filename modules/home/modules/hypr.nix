{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs = {
    hyprlock.enable = true;
  };
}

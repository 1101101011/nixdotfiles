{ config, lib, pkgs, inputs, ... }:

{
  imports =[
      ./../../modules/core
      ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    tlp
  ];
}


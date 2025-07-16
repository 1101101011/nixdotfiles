{ config, lib, pkgs, inputs, ... }:
{
  hardware = {
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
    bluetooth = {
      powerOnBoot = false;
      package = pkgs.bluez;
      enable = true;
      settings = {
        General = {
          Name = "Hello";
          ControllerMode = "dual";
          FastConnectable = "true";
          Experimental = "true";
        };
        Policy = {
          AutoEnable = "false";
        };
      };
    };
  };
}


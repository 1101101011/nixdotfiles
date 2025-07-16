{ config, lib, pkgs, inputs, username, host, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      imports = [
        ./../home
      ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "25.05";
      programs.home-manager.enable = true;
    };
  };
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "nginx" ];
  };
  security.sudo.extraRules = [
    {
      users = [ "${username}" ];
      commands = [ 
        { 
	  command = "/run/current-system/sw/bin/tlp-stat";
	  options = [ "SETENV" "NOPASSWD" ]; 
	} 
      ];
    }
  ];
  nix.settings.allowed-users = [ "${username}" ];
}

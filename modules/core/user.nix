{ username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "nginx"
      "kvm"
      "adbusers"
    ];
  };
  security.sudo.extraRules = [
    {
      users = [ "${username}" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/tlp-stat";
          options = [
            "SETENV"
            "NOPASSWD"
          ];
        }
      ];
    }
  ];
  nix.settings = {
    # allowed-users = ["${username}"];
    allowed-users = [ "*" ];
    trusted-users = [
      "root"
      "@wheel"
      "github-runner-enic-mis"
    ];
  };
}

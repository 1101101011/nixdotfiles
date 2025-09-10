{
  config,
  lib,
  pkgs,
  inputs,
  host,
  ...
}:
{
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking = {
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    hostName = "${host}";
    dhcpcd.enable = false;
    useDHCP = false;
    networkmanager = {
      dns = "none";
      enable = true;
      wifi.powersave = true;
    };
    interfaces = {
      wlp3s0 = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "192.168.1.69";
            prefixLength = 24;
          }
        ];
      };
    };
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        22
        80
        443
        5432
        3306
        5050
      ];
      # allowedUDPPorts = [ ... ];
    };
    defaultGateway = "192.168.1.1";
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };
}

{
  pkgs,
  ...
}:
{
  imports = [
    ./../../modules/core
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
    tlp
    acpi
  ];
}

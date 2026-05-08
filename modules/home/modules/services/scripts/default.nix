{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    myService.enable = lib.mkEnableOption "Enable Custom Services for Battery Status and Alerts in Laptop";
  };
  config = lib.mkIf config.myService.enable {
    home.file = {
      ".local/bin/battery-alert" = {
        source = ./battery-alert.sh;
        executable = true;
      };
      ".local/bin/battery-status" = {
        source = ./battery-status.sh;
        executable = true;
      };
    };
    systemd.user = {
      services = {
        battery-status = {
          Unit.Description = "Battery status notifier";
          Service = {
            Type = "oneshot";
            ExecStart = "${pkgs.bash}/bin/bash %h/.local/bin/battery-status";
          };
        };
        battery-alert = {
          Unit.Description = "Battery alert notifier";
          Service = {
            Type = "oneshot";
            ExecStart = "${pkgs.bash}/bin/bash %h/.local/bin/battery-alert";
          };
        };
      };
      timers.battery-alert = {
        Unit.Description = "Run battery alert every minute";
        Timer = {
          OnUnitActiveSec = "1m";
          OnBootSec = "1m";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}

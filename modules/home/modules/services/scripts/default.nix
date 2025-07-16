{ pkgs, ... }:
{
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
        Unit.description = "Battery status notifier";
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.bash}/bin/bash %h/.local/bin/battery-status";
        };
      };
      battery-alert = {
        Unit.description = "Battery alert notifier";
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.bash}/bin/bash %h/.local/bin/battery-alert";
        };
      };
    };
    timers.battery-alert = {
      Unit.description = "Run battery alert every minute";
      Timer = {
        OnUnitActiveSec = "1m";
        OnBootSec = "1m";
      };
      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };
}

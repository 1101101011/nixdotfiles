{ config, lib, pkgs, inputs, ... }:
{
  services.udev = {
    enable = true;
    packages = [
      (pkgs.writeTextFile {
        name = "battery-stats";
        text = ''
      	  ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0",\
      	  ENV{DISPLAY}=":0",\
      	  ENV{DBUS_SESSION_BUS_ADDRESS }="unix:path=/run/user/1000/bus" \
      	  RUN+="${pkgs.su}/bin/su Shiroe -c '/home/Shiroe/.local/bin/battery-status Discharging'"
      
      	  ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1",\
      	  ENV{DISPLAY}=":0",\
      	  ENV{DBUS_SESSION_BUS_ADDRESS }="unix:path=/run/user/1000/bus" \
      	  RUN+="${pkgs.su}/bin/su Shiroe -c '/home/Shiroe/.local/bin/battery-status Charging'"
        '';
        destination = "/etc/udev/rules.d/60-power.rules";
      })
    ];
  };
}


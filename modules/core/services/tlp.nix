{ ... }:
{
  services.tlp = {
    enable = true;
      settings = {
      START_CHARGE_THRESH_BAT0 = 25;
      STOP_CHARGE_THRESH_BAT0 = 90;
      START_CHARGE_THRESH_BAT1 = 25;
      STOP_CHARGE_THRESH_BAT1 = 90;
    };
  };
}

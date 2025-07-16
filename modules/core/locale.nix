{ config, lib, pkgs, inputs, ... }:
{
  # Set your time zone.
  time.timeZone = "Asia/Manila";
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Internationalization
  services.xserver.xkb.layout = "us";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "en_PH.UTF-8";          # Overall locale fallback
      LC_CTYPE = "en_PH.UTF-8";        # Character encoding
      LC_ADDRESS = "en_PH.UTF-8";      # Address formats (Filipino if available, else en_PH.UTF-8)
      LC_IDENTIFICATION = "en_PH.UTF-8"; # Identification formats
      LC_MEASUREMENT = "en_PH.UTF-8";   # Metric system (used in PH)
      LC_MESSAGES = "en_PH.UTF-8";      # System messages in English
      LC_MONETARY = "en_PH.UTF-8";     # Philippine Peso formatting
      LC_NAME = "en_PH.UTF-8";         # Name formats (Filipino if available)
      LC_NUMERIC = "en_PH.UTF-8";      # Number formatting
      LC_PAPER = "en_PH.UTF-8";         # Paper size (A4 is common in PH)
      LC_TELEPHONE = "en_PH.UTF-8";    # Telephone number formats
      LC_TIME = "en_US.UTF-8";          # Time and date formatting
      LC_COLLATE = "en_PH.UTF-8";       # Sorting and collation
    };
    supportedLocales = [ "all" ];
  };
}


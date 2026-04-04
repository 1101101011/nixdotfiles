{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    postgres.enable = lib.mkEnableOption "Enable PostgreSQL";
  };
  config = lib.mkIf config.postgres.enable {
    services = {
      postgresql = {
        package = pkgs.postgresql_18;
        enable = true;
        enableTCPIP = true;
        settings.port = 5432;
        authentication = pkgs.lib.mkOverride 10 ''
          #...
          #type database DBuser origin-address auth-method
          local all       all     trust
          # ipv4
          host  all      all     127.0.0.1/32   trust
          # ipv6
          host all       all     ::1/128        trust
        '';
      };
      pgadmin = {
        enable = true;
        port = 5050;
        openFirewall = true;
        initialEmail = "admin@admin.com";
        initialPasswordFile = ./secrets/pgadmin_password.txt;
        settings = {
          "ALLOWED_HOSTS" = [
            "127.0.0.1"
            "localhost"
            "192.168.1.0/24"
          ];
        };
        minimumPasswordLength = 6;
      };
    };
  };
}


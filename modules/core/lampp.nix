{ config, lib, pkgs, inputs, ... }:
{
  services = {
    nginx = {
      enable = true;
      virtualHosts."phpmyadmin.com" = {
        enableACME = false; # Optional: Enables Let's Encrypt SSL
        forceSSL = false;   # Optional: Forces HTTPS
        root = "/var/www/phpmyadmin";
	locations."~ \\.php$".extraConfig = ''
          fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
          fastcgi_index index.php;
        '';
      };
    };
    phpfpm.pools."mypool" = {
      user = "nobody";
      # group = "nogroup";
      # phpPackage = pkgs.php81.withExtensions ({ enabled, all }: enabled ++ [ all.mysqli all.gd ]);
      settings = {
        "pm" = "dynamic";
	"listen.owner" = config.services.nginx.user;
        "pm.max_children" = 5;
        "pm.start_servers" = 2;
        "pm.min_spare_servers" = 1;
        "pm.max_spare_servers" = 3;
        "pm.max_requests" = 500;
      };
      # phpOptions = ''
      #   upload_max_filesize = 200M
      #   post_max_size = 200M
      #   date.timezone = "Asia/Manila"
      # '';
    };
    mysql = {
      enable = true;
      package = pkgs.mariadb;
      dataDir = "/var/lib/mysql";
      settings = {
        mysqld = {
          plugin-load-add = [ "server_audit.so" ];
          server-audit-file-path = "server_audit.log";
          server-audit-events = "CONNECT,QUERY,TABLE";
          server_audit_file_rotate_size = "1G";
          server_audit_file_rotations = 10;
          server_audit_logging = "ON";
          server_audit_output_type = "file";
          server_audit_incl_users = ",test11,root";
          # general_log = 1;
          # general_log_file = "/var/log/mariadb/general_query.log";
        };
      };
    };
    postgresql = {
      enable = true;
      # ensureDatabases = [ "mydatabase" ];
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
        "ALLOWED_HOSTS" = [ "127.0.0.1" "localhost" "192.168.1.0/24" ];
      };
      minimumPasswordLength = 6;

    };
  };
}

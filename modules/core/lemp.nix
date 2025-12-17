{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  services = {
    nginx = {
      enable = true;
      virtualHosts."pup-con.com" = {
        enableACME = false;
        forceSSL = false;
        root = "/var/www/PUPCON/public";
        extraConfig = ''
          client_max_body_size 3000M;
          fastcgi_buffers 8 16k;
          fastcgi_buffer_size 32k;
          fastcgi_connect_timeout 300;
          fastcgi_send_timeout 300;
          fastcgi_read_timeout 300;
        '';

        locations."/".extraConfig = ''
          index index.php;
          try_files $uri $uri/ /index.php?$query_string;
        '';

        /*
             locations."~ \\.php$".extraConfig = ''
            include ${pkgs.nginx}/conf/fastcgi.conf;
            fastcgi_pass unix:${config.services.phpfpm.pools.pupcon.socket};
          '';
        */
        locations."~ \\.php$".extraConfig = ''
          include ${pkgs.nginx}/conf/fastcgi.conf;
          fastcgi_pass unix:${config.services.phpfpm.pools.pupcon.socket};
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        '';

        locations."= /favicon.ico".extraConfig = ''
          access_log off;
          log_not_found off;
        '';

        locations."= /robots.txt".extraConfig = ''
          access_log off;
          log_not_found off;
        '';

        locations."/build/".extraConfig = ''
          try_files $uri =404;
        '';

        locations."/storage/".extraConfig = ''
          alias /var/www/PUPCON/storage/app/public/;
          access_log off;
          log_not_found off;
          autoindex off;
          add_header X-Content-Type-Options nosniff;
        '';
      };
    };
    /*
           virtualHosts."phpmyadmin.com" = {
          enableACME = false; # Optional: Enables Let's Encrypt SSL
          forceSSL = false;   # Optional: Forces HTTPS
          root = "/var/www/phpmyadmin";
         locations."/".extraConfig = ''
            index index.php;
            try_files $uri $uri/ /index.php?$query_string;
          '';
         locations."~ \.php$".extraConfig = ''
            include ${pkgs.nginx}/conf/fastcgi.conf;
            fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
          '';
        };
      };
    */
    phpfpm.pools."pupcon" = {
      user = "nginx";
      group = "nginx";
      phpPackage = pkgs.php84.withExtensions (
        {
          enabled,
          all,
        }:
        enabled
        ++ [
          all.mysqli
          all.gd
        ]
      );
      settings = {
        "pm" = "dynamic";
        "listen.owner" = config.services.nginx.user;
        "pm.max_children" = 5;
        "pm.start_servers" = 2;
        "pm.min_spare_servers" = 1;
        "pm.max_spare_servers" = 3;
        "pm.max_requests" = 500;
        "request_terminate_timeout" = "300s";
      };
      phpOptions = ''
        upload_max_filesize = 2G
        post_max_size = 3G
        max_execution_time = 6000
        max_input_time = 3000
        mbstring.http_input = pass
        mbstring.http_output = pass
        mbstring.internal_encoding = pass
        memory_limit = 2G
        allow_url_include = on;
        display_errors = on;
        date.timezone = "Asia/Manila"
      '';
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
}

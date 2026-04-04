{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    nginx.enable = lib.mkEnableOption "Enable Nginx";
  };
  config = lib.mkIf config.nginx.enable {
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
    };
  };
}

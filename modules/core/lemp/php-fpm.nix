{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    php-fpm.enable = lib.mkEnableOption "Enable PHP-FPM";
  };
  config = lib.mkIf config.lemp.enable {
    services = {
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
    };
  };
}


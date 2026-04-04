{
  lib,
  host,
  ...
}:
{
  imports = [
    ./nginx.nix
    ./php-fpm.nix
    ./postgres.nix
  ];

  config = lib.mkMerge [
    (lib.mkIf (host != "Kagami") {
      php-fpm.enable = true;
      nginx.enable = true;
      postgrs.enable = true;
    })

    (lib.mkIf (host == "Kagami") {
      php-fpm.enable = false;
      nginx.enable = false;
      postgrs.enable = false;
    })
  ];
  /*services = {
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
  };*/
}

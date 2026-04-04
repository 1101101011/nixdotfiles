{
  lib,
  config,
  ...
}:
{
  options = {
    gh-runners.enable = lib.mkEnableOption "Enable Github Runners for Githuba Actions";
  };
  config = lib.mkIf config.gh-runners.enable {
    services.github-runners = {
      enic-mis = {
        enable = true;
        url = "https://github.com/RonRon-Dev/ENIC-INTERNS-PROJECT";
        tokenFile = "/home/Shiroe/github/nixdotfiles/modules/core/secrets/token-file.txt";
        name = "enic-mis-nixos";
      };
    };
  };
}

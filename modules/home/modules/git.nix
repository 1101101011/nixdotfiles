{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs = {
    # git-credential-oauth.enable = true;
    git = {
      enable = true;
      settings = {
        user = {
          name = "1101101011";
          email = "ilardecharles@gmail.com";
        };
        init.defaultBranch = "main";
        pull.rebase = true;
        credential.helper = "oauth";
      };
    };
  };
}

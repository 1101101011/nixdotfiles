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
      userName = "1101101011";
      userEmail = "ilardecharles@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        credential.helper = "oauth";
      };
    };
  };
}

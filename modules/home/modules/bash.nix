{ ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "lsd";
      tree = "lsd --tree";
    };
    bashrcExtra = ''
      [[ -z "$TMUX" ]] && nitch
    '';
    enableCompletion = true;
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}

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
}

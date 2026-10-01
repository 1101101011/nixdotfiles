{ ... }:
{
  xdg.configFile."superfile/config.toml" = {
    source = ./config.toml;
  };
  programs.superfile = {
    enable = true;
  };
}

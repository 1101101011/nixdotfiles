{
  pkgs,
  config,
  helix,
  ...
}: {

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox-theme";
      editor = {
        statusline = {
          separator = "";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };
        cursor-shape = {
          normal = "block";
          insert = "block";
          select = "block";
        };
        color-modes = true;
        mouse = false;
        line-number = "relative";
      };
    };
    themes = {
      gruvbox-theme = {
        "inherits" = "gruvbox";
        "ui.background" = {};
      };
    };
  };
}


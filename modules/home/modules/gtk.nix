{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  options = {
    myGtk.enable = lib.mkEnableOption "Enable GTK theming and configuration";
  };
  config = lib.mkIf config.myGtk.enable {
    home.sessionVariables.GTK_THEME = "Gruvbox-Dark";
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox)";
      size = 16;
    };
    gtk = {
      enable = true;
      theme = {
        package = pkgs.gruvbox-gtk-theme;
        name = "Gruvbox-Dark";
      };
      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons.override {
          folder-color = "blue";
        };
      };
      font = {
        name = "JetBrains Mono";
        size = 11;
      };
    };
  };
}

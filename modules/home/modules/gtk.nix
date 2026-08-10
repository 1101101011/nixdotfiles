{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    myGtk.enable = lib.mkEnableOption "Enable GTK theming and configuration";
  };
  config = lib.mkIf config.myGtk.enable {
    # home.sessionVariables.GTK_THEME = "gruvterial";
    home.pointerCursor = {
      enable = true;
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox)";
      size = 16;
    };
    gtk = {
      enable = true;
      gtk4 = {
        theme = {
          package = pkgs.gruvterial-theme;
          name = "gruvterial";
        };
      };
      gtk3 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
        theme = {
          package = pkgs.gruvterial-theme;
          name = "gruvterial";
        };
      };
      /*
           gtk4.theme = {
          package = pkgs.gruvbox-gtk-theme;
          name = "Gruvbox-Dark";
        };
        theme = {
          package = pkgs.gruvbox-gtk-theme;
          name = "Gruvbox-Dark";
        };
      */
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

{ config, pkgs, lib, inputs, ... }:
{
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
      package = pkgs.gruvbox-gtk-theme.override {
        sizeVariants = [ "standard" ];
        colorVariants = [ "dark" ];
			};
      name = "Gruvbox-Dark";
    };
    iconTheme = {
      package = pkgs.gruvbox-plus-icons.override {
				folder-color = "blue";
			};
      name = "Gruvbox-Plus-Dark";
    };
    font = {
      name = "JetBrains Mono";
      size = 11;
    };
  };
}

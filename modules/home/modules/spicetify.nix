{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  programs.spicetify =
    let
      spicetifyPkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      theme = spicetifyPkgs.themes.dribbblish;
      colorScheme = "gruvbox";
      enabledExtensions = with spicetifyPkgs.extensions; [
        fullAppDisplay
        adblock
        shuffle
        hidePodcasts
      ];
    };
}

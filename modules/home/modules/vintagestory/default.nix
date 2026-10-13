{
  pkgs,
  config,
  lib,
  ...
}:
let
  vintageStory = pkgs.vintagestory.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      install -Dm644 ${./VintagestoryLib.dll} \
        "$out/share/vintagestory/CustomPatch.dll"
    '';
  });
in
{
  options = {
    myVintageStory.enable = lib.mkEnableOption "Custom patch for Vintage Story";
  };
  config = lib.mkIf config.myVintageStory.enable {
    home.packages = [ vintageStory ];
  };
}

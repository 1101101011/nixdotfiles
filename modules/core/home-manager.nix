{
  lib,
  inputs,
  username,
  host,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      imports = [
        ./../home
      ];

      config = lib.mkMerge [
        {
          home.username = "${username}";
          home.homeDirectory = "/home/${username}";
          home.stateVersion = "26.05";
          programs.home-manager.enable = true;

          myDunst.enable = true;
          myFonts.enable = true;
          myGtk.enable = true;
          myHypr.enable = true;
          myService.enable = true;
          kube-home.enable = true;
        }

        /* (lib.mkIf (host == "Kurohikari") {
          myDunst.enable = true;
          myFonts.enable = true;
          myGtk.enable = true;
          myHypr.enable = true;
          myService.enable = true;
        }) */

        /* (lib.mkIf (host != "Kurohikari") {
          myDunst.enable = true;
          myFonts.enable = true;
          myGtk.enable = true;
          myHypr.enable = true;
          myService.enable = true;
        }) */
      ];
    };
  };
}

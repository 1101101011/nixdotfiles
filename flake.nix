{
  description = "Nixos Flake for my Laptop, Desktop and VM";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";#/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    showkeys = {
      url = "github:nvzone/showkeys";
      flake = false;
    };
    none-ls-extras = {
      url = "github:nvimtools/none-ls-extras.nvim";
      flake = false;
    };
    csv-view = {
      url = "github:hat0uma/csvview.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations ={
      NixOs = nixpkgs.lib.nixosSystem {
        inherit system;
	specialArgs = { 
	  host = "NixOs";
	  username = "Shiroe";
	  inherit self inputs; 
	};
        modules = [
          ./hosts/laptop
          # home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   home-manager.users.Shiroe = import ./modules/home-manager/home.nix;
          #   home-manager.extraSpecialArgs = { inherit inputs; };
          # }
        ];
      };
    };
  };
}

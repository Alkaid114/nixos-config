{
  description = "Alkaid's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake =
        let
          username = "alkaid";
          genRev = {
            system.configurationRevision = self.rev or null;
            system.nixos.label =
              if self ? lastModifiedDate && self ? shortRev then
                "${builtins.substring 0 8 self.lastModifiedDate}.${self.shortRev}"
              else
                "0-dirty";
          };
          overlays = import ./overlays { inherit inputs; };
        in
        {
          nixosConfigurations = {
            asus-tx5pro = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = { inherit username inputs; };
              modules = [
                ./hosts/asus-tx5pro
                ./modules/system
                ./modules/desktop
                ./modules/develop
                ./modules/gaming
                ./modules/virtual
                inputs.stylix.nixosModules.stylix
                genRev
              ];
            };
            iso = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs;
                username = "nixos";
              };
              modules = [
                "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
                "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
                ./modules/desktop/proxy.nix
                ./hosts/iso
              ];
            };
          };

          homeConfigurations = {
            alkaid = inputs.home-manager.lib.homeManagerConfiguration {
              extraSpecialArgs = { inherit inputs username; };
              pkgs = import inputs.nixpkgs {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
              modules = [
                ./home
                {
                  nixpkgs.overlays = overlays;
                }
                {
                  home = {
                    inherit username;
                    homeDirectory = "/home/${username}";
                    stateVersion = "26.05";
                  };
                }
                inputs.stylix.homeModules.stylix
              ];
            };
          };
        };
      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-tree;
          packages = {
            ttf-ms-win11-auto = pkgs.callPackage ./packages/ttf-ms-win11-auto.nix { };
            ttf-ms-win11-auto-zh_cn = pkgs.callPackage ./packages/ttf-ms-win11-auto-zh_cn.nix { };
            ttf-ms-win11-fod-auto-hans = pkgs.callPackage ./packages/ttf-ms-win11-fod-auto-hans.nix { };
          };
        };
    };
}

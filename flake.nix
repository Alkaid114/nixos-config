{
  description = "Alkaid's NixOS flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake";
    stylix.url = "github:nix-community/stylix";
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      chaotic,
      niri,
      stylix,
      dankMaterialShell,
      quickshell,
      ...
    }@inputs:
    let
      mkHost =
        { hostname, username }:
        let
          STATE_VERSION = "25.05";
        in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inputs = inputs;
            hostname = hostname;
            username = username;
            STATE_VERSION = STATE_VERSION;
          };
          modules = [
            ./hosts/${hostname}
            ./system

            niri.nixosModules.niri
            stylix.nixosModules.stylix

            {
              nixpkgs.overlays = [
                #niri.overlays.niri
                (final: prev: {
                  niri = (niri.overlays.niri final prev).niri.overrideAttrs (old: {
                    doCheck = false;
                  });
                })
              ];
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${username} = {
                home = {
                  inherit username;
                  homeDirectory = "/home/${username}";
                  stateVersion = STATE_VERSION;
                };

                imports = [
                  ./home
                  stylix.homeModules.stylix
                  dankMaterialShell.homeModules.dankMaterialShell.default
                  dankMaterialShell.homeModules.dankMaterialShell.niri
                ];
              };
              home-manager.extraSpecialArgs = {
                # inherit (inputs) plasma-manager;
                inherit username;
                inherit hostname;
              };
            }

            chaotic.nixosModules.nyx-cache
            chaotic.nixosModules.nyx-overlay
            chaotic.nixosModules.nyx-registry
          ];
        };
    in
    {
      nixosConfigurations = {
        alkaid-qemu = mkHost {
          hostname = "alkaid-qemu";
          username = "alkaid";
        };
        asus-rtx4060 = mkHost {
          hostname = "asus-rtx4060";
          username = "alkaid";
        };
      };
    };
}

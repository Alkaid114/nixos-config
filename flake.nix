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

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    substituters = [
      "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.nju.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake =
        let
          username = "alkaid";
        in
        {
          nixosConfigurations = {
            asus-tx5pro = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = { inherit username inputs; };
              modules = [
                ./hosts/asus-tx5pro
                ./modules/system
                ./modules/desktop
                ./modules/desktop/baseline.nix
                ./modules/develop
                ./modules/gaming
                ./modules/virtual
                inputs.stylix.nixosModules.stylix
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
        };
    };
}

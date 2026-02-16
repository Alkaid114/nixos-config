{
  description = "Alkaid's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
    stylix.url = "github:nix-community/stylix";
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

    # nixos-grub-themes = {
    #   url = "github:jeslie0/nixos-grub-themes";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
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
                ./os/desktop.nix
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
                ./os/program/proxy.nix
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

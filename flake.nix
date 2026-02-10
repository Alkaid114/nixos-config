{
  description = "Alkaid's NixOS flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
    # stylix.url = "github:nix-community/stylix";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
  };

  nixConfig = {
    substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  };

  outputs = inputs@{ flake-parts, ...}:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake = let
          username = "alkaid";
      in {
        nixosConfigurations = {
          asus-tx5pro = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = { inherit username inputs; };
            modules = [
              ./hosts/asus-tx5pro/driver.nix
              ./os
              # inputs.stylix.nixosModules.stylix
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
                  stateVersion = "25.11";
                };
              }
              # inputs.stylix.homeModules.stylix
            ];
          };
        };
      };
    };
}

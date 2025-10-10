{
  description = "Alkaid's NixOS flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake";
    stylix.url = "github:nix-community/stylix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-ros-overlay = {
      url = "github:lopsided98/nix-ros-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
  };

  outputs =
    {
      self,
      flake-parts,
      nixpkgs,
      home-manager,
      stylix,
      chaotic,
      quickshell,
      dankMaterialShell,
      nix-ros-overlay,
      niri,
      nixos-grub-themes,
      ...
    }@inputs:

    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake =
        {
          # inputs,
          ...
        }:
        let
          stateVersion = "25.05";
          username = "alkaid";
        in
        {
          description = "Alkaid's NixOS flake";

          nixosConfigurations = {
            asus-rtx4060 = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit username;
                inherit stateVersion;
                inherit inputs;
              };
              modules = [
                ./hosts/asus-rtx4060/driver.nix
                ./os

                home-manager.nixosModules.home-manager
                {
                  home-manager.extraSpecialArgs = {
                    inherit stateVersion;
                    inherit username;
                  };
                  home-manager.useUserPackages = true;
                  home-manager.users.${username} = {
                    nixpkgs.config.allowUnfree = true;
                    home = {
                      username = username;
                      homeDirectory = "/home/${username}";
                      stateVersion = stateVersion;
                    };
                    imports = [
                      ./home
                      stylix.homeModules.stylix
                      dankMaterialShell.homeModules.dankMaterialShell.default
                      dankMaterialShell.homeModules.dankMaterialShell.niri
                    ];
                  };
                }

                {
                  nixpkgs.overlays = [
                    niri.overlays.niri
                  ];
                }

                niri.nixosModules.niri
                stylix.nixosModules.stylix
                chaotic.nixosModules.nyx-cache
                chaotic.nixosModules.nyx-overlay
                chaotic.nixosModules.nyx-registry
              ];
            };
          };
        };

      perSystem =
        {
          pkgs,
          ...
        }:
        {
          devShells = {
            # default = pkgs.mkShell {
            #   packages = with pkgs; [
            #     git
            #     gcc
            #   ];
            # };
            cpp = pkgs.mkShell {
              name = "cpp";
              shell = pkgs.zsh;

              buildInputs = with pkgs; [
                cmake
                gnumake
                gcc
                clang
                clang-tools # includes clangd
                eigen
                pcl
                opencv
              ];

              shellHook = ''
                exec zsh
                [ -f ~/.zshrc ] && source ~/.zshrc
                echo "Welcome to the C++ devshell!"
                echo "Tools available: cmake, gcc, clang, clangd, eigen, pcl, opencv"
              '';
            };

            ros =
              let
                pkgs = import nixpkgs {
                  system = "x86_64-linux";
                  overlays = [
                    nix-ros-overlay.overlays.default
                  ];
                };
              in
              pkgs.mkShell {
                packages = [
                  pkgs.colcon
                  pkgs.cmake
                  pkgs.git
                  # ... other non-ROS packages
                  (
                    with pkgs.rosPackages.humble;
                    buildEnv {
                      paths = [
                        ros-core
                        # ... other ROS packages
                      ];
                    }
                  )
                ];
              };
          };
        };
    };
  nixConfig = {
    extra-substituters = [ "https://ros.cachix.org" ];
    extra-trusted-public-keys = [ "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=" ];
  };
}

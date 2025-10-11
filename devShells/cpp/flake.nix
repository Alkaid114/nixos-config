{
  description = "C++ DevShell Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        opencvGtk = pkgs.opencv.override {
          enableGtk3 = true;
          enableGtk2 = false;
          #           enableCuda = true;
          enableEigen = true;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "cpp";
          shell = pkgs.zsh;
          stdenv = pkgs.gccStdenv;
          NIX_BUILD_CORES = "16";

          buildInputs = with pkgs; [
            cmake
            gnumake
            # gcc
            # clang
            opencvGtk
            clang-tools # includes clangd
            eigen
            pcl
            gtk3
            pkg-config
            # glibc
          ];

          shellHook = ''
            echo "Welcome to the C++ devshell!"
            echo "Tools available: cmake, glibc, make, gcc, clangd, eigen, pcl, opencv"
          '';
        };
      }
    );
}

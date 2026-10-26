{
  description = "GCC C/C++ development environment with Clangd";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    flake-utils.url = "github:numtide/flake-utils";
  };

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
        };
        llvm23 = pkgs.llvmPackages_23;
        clangdWithGcc = pkgs.writeShellScriptBin "clangd" ''
          exec env LC_ALL=C ${llvm23.clang-tools}/bin/clangd \
            --query-driver=${pkgs.stdenv.cc}/bin/g++,${pkgs.stdenv.cc}/bin/gcc \
            "$@"
        '';
        nativeBuildInputs = with pkgs; [
          meson
          ninja
          pkg-config
        ];
        buildInputs = with pkgs; [
          gtest
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          name = "gcc-clangd-dev";

          packages =
            nativeBuildInputs
            ++ buildInputs
            ++ (with pkgs; [
              stdenv.cc
              gdb
              valgrind
              clangdWithGcc
              llvm23.clang-tools
            ]);

          shellHook = ''
            export CC="${pkgs.stdenv.cc}/bin/gcc"
            export CXX="${pkgs.stdenv.cc}/bin/g++"
          '';
        };

        formatter = pkgs.nixfmt;
      }
    );
}

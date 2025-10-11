{
  description = "Zig DevShell Flake";

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
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "zig";
          shell = pkgs.zsh;

          buildInputs = with pkgs; [
            zig
            zls
          ];

          shellHook = ''
            echo "Welcome to the Zig devshell!"
            echo "Tools available: zig"
          '';
        };
      }
    );
}

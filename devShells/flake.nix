{
  description = "DevShell Flake Template";

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
          name = "my-devshell";

          packages = with pkgs; [
            git
            hello
            nixfmt
          ];

          shellHook = ''
            exec zsh
            echo "Welcome to your devShell"
          '';
        };
      }
    );
}
